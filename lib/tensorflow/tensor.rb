module TensorFlow
  class Tensor
    def initialize(value = nil, dtype: nil, shape: nil, pointer: nil)
      @status = FFI.TF_NewStatus

      if pointer
        @pointer = pointer
      else
        data = value
        data = Array(data) unless data.is_a?(Array) || data.is_a?(Numo::NArray)
        shape ||= calculate_shape(value)

        if shape.size > 0
          dims_ptr = ::FFI::MemoryPointer.new(:int64, shape.size)
          dims_ptr.write_array_of_int64(shape)
        else
          dims_ptr = nil
        end

        if data.is_a?(Numo::NArray)
          dtype ||= Utils.infer_type(data)
          # TODO use Numo read pointer?
          data_ptr = ::FFI::MemoryPointer.new(:uchar, data.byte_size)
          data_ptr.write_bytes(data.to_string)
        else
          data = data.flatten
          dtype ||= Utils.infer_type(data)
          case dtype
          when :float, :double, :int32, :uint8, :int16, :int8, :int64, :uint16, :uint32, :uint64
            data_ptr = ::FFI::MemoryPointer.new(dtype, data.size)
            data_ptr.send("write_array_of_#{dtype}", data)
          when :bfloat16
            # https://en.wikipedia.org/wiki/Bfloat16_floating-point_format
            data_ptr = ::FFI::MemoryPointer.new(:int8, data.size * 2)
            data_ptr.write_bytes(data.map { |v| [v].pack("g")[0..1] }.join)
          when :complex64
            data_ptr = ::FFI::MemoryPointer.new(:float, data.size * 2)
            data_ptr.write_array_of_float(data.flat_map { |v| [v.real, v.imaginary] })
          when :complex128
            data_ptr = ::FFI::MemoryPointer.new(:double, data.size * 2)
            data_ptr.write_array_of_double(data.flat_map { |v| [v.real, v.imaginary] })
          when :string
            data_ptr = string_ptr(data)
          when :bool
            data_ptr = ::FFI::MemoryPointer.new(:int8, data.size)
            data_ptr.write_array_of_int8(data.map { |v| v ? 1 : 0 })
          else
            raise "Unknown type: #{dtype}"
          end
        end

        type = FFI::DataType[dtype]

        callback = ::FFI::Function.new(:void, [:pointer, :size_t, :pointer]) do |data, len, arg|
          # FFI handles deallocation
        end

        # keep data pointer alive for duration of object
        @data_ptr = data_ptr
        @dims_ptr = dims_ptr
        @callback = callback

        tensor = FFI.TF_NewTensor(type, dims_ptr, shape.size, data_ptr, data_ptr.size, callback, nil)
        @pointer = FFI.TFE_NewTensorHandle(tensor, @status)
        check_status @status
      end

      ObjectSpace.define_finalizer(self, self.class.finalize(@pointer, @status, tensor))
    end

    def +(other)
      Math.add(self, other)
    end

    def -(other)
      Math.subtract(self, other)
    end

    def *(other)
      Math.multiply(self, other)
    end

    def /(other)
      Math.divide(self, other)
    end

    def %(other)
      Math.floormod(self, other)
    end

    def -@
      Math.negative(self)
    end

    def value
      value =
        case dtype
        when :float, :double, :int32, :uint8, :int16, :int8, :int64, :uint16, :uint32, :uint64
          data_pointer.send("read_array_of_#{dtype}", element_count)
        when :bfloat16
          byte_str = data_pointer.read_bytes(element_count * 2)
          element_count.times.map { |i| "#{byte_str[(2 * i)..(2 * i + 1)]}\x00\x00".unpack1("g") }
        when :complex64
          data_pointer.read_array_of_float(element_count * 2).each_slice(2).map { |v| Complex(*v) }
        when :complex128
          data_pointer.read_array_of_double(element_count * 2).each_slice(2).map { |v| Complex(*v) }
        when :string
          tf_string_size = 24
          element_count.times.map do |i|
            FFI.TF_StringGetDataPointer(data_pointer + i * tf_string_size)
          end
        when :bool
          data_pointer.read_array_of_int8(element_count).map { |v| v == 1 }
        when :resource, :variant
          return data_pointer
        else
          raise "Unknown type: #{dtype}"
        end

      reshape(value, shape)
    end

    def dtype
      @dtype ||= FFI::DataType[FFI.TFE_TensorHandleDataType(@pointer)]
    end

    def shape
      @shape ||= begin
        shape = []
        num_dims.times do |i|
          shape << FFI.TFE_TensorHandleDim(@pointer, i, @status)
          check_status @status
        end
        shape
      end
    end

    def to_s
      inspect
    end

    def to_i
      value.to_i
    end

    def to_a
      value
    end

    def to_ptr
      @pointer
    end

    def numo
      klass = Utils::NUMO_TYPE_MAP[dtype]
      raise "Unknown type: #{dtype}" unless klass
      klass.cast(value)
    end

    def inspect
      inspection = %w(numo shape dtype).map { |v| "#{v}: #{send(v).inspect}"}
      "#<#{self.class} #{inspection.join(", ")}>"
    end

    def self.finalize(pointer, status, tensor)
      # must use proc instead of stabby lambda
      proc do
        FFI.TFE_DeleteTensorHandle(pointer)
        FFI.TF_DeleteStatus(status)
        # FFI.TF_DeleteTensor(tensor) if tensor
      end
    end

    private

    def num_dims
      ret = FFI.TFE_TensorHandleNumDims(@pointer, @status)
      check_status @status
      ret
    end

    def element_count
      ret = FFI.TFE_TensorHandleNumElements(@pointer, @status)
      check_status @status
      ret
    end

    def data_pointer
      FFI.TF_TensorData(tensor_pointer)
    end

    def tensor_pointer
      tensor = FFI.TFE_TensorHandleResolve(@pointer, @status)
      check_status @status
      tensor
    end

    def reshape(arr, dims)
      return arr.first if dims.empty?
      arr = arr.flatten
      dims[1..-1].reverse.each do |dim|
        arr = arr.each_slice(dim)
      end
      arr.to_a
    end

    def calculate_shape(value)
      return value.shape if value.respond_to?(:shape)

      shape = []
      d = value
      while d.is_a?(Array)
        shape << d.size
        d = d.first
      end
      shape
    end

    def string_ptr(data)
      tf_string_size = 24
      data_ptr = ::FFI::MemoryPointer.new(:char, data.size * tf_string_size)
      data.each_with_index do |str, i|
        offset = data_ptr + i * tf_string_size
        FFI.TF_StringInit(offset)
        FFI.TF_StringCopy(offset, str, str.bytesize)
      end
      data_ptr
    end

    def check_status(status)
      Utils.check_status(status)
    end
  end
end
