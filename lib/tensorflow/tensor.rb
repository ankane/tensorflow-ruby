module TensorFlow
  class Tensor
    def initialize(value = nil, dtype: nil, shape: nil, pointer: nil)
      @status = FFI.TF_NewStatus

      if pointer
        @pointer = pointer
      else
        data = Array(value)
        shape ||= calculate_shape(value)

        if shape.size > 0
          dims_ptr = ::FFI::MemoryPointer.new(:int64, shape.size)
          dims_ptr.write_array_of_int64(shape)
        else
          dims_ptr = nil
        end

        data = data.flatten

        dtype ||= Utils.infer_type(value)
        type = FFI::DataType[dtype]
        case dtype
        when :string
          data_ptr = string_ptr(data)
        when :float
          data_ptr = ::FFI::MemoryPointer.new(:float, data.size)
          data_ptr.write_array_of_float(data)
        when :int32
          data_ptr = ::FFI::MemoryPointer.new(:int32, data.size)
          data_ptr.write_array_of_int32(data)
        else
          raise "Unknown type: #{dtype}"
        end

        callback = ::FFI::Function.new(:void, [:pointer, :size_t, :pointer]) do |data, len, arg|
          # FFI handles deallocation
        end

        tensor = FFI.TF_NewTensor(type, dims_ptr, shape.size, data_ptr, data_ptr.size, callback, nil)
        @pointer = FFI.TFE_NewTensorHandle(tensor, @status)
        check_status @status
      end

      # TODO fix segfault
      # ObjectSpace.define_finalizer(self, self.class.finalize(@pointer))
    end

    def +(other)
      TensorFlow.add(self, other)
    end

    def -(other)
      TensorFlow.subtract(self, other)
    end

    def *(other)
      TensorFlow.multiply(self, other)
    end

    def /(other)
      TensorFlow.divide(self, other)
    end

    def %(other)
      TensorFlow.floormod(self, other)
    end

    def value
      value =
        case dtype
        when :float
          data_pointer.read_array_of_float(element_count)
        when :int32
          data_pointer.read_array_of_int32(element_count)
        when :string
          # string tensor format
          # https://github.com/tensorflow/tensorflow/blob/5453aee48858fd375172d7ae22fad1557e8557d6/tensorflow/c/tf_tensor.h#L57
          start_offset_size = element_count * 8
          offsets = data_pointer.read_array_of_uint64(element_count)
          element_count.times.map { |i| (data_pointer + start_offset_size + offsets[i]).read_string }
        when :bool
          data_pointer.read_array_of_int8(element_count).map { |v| v == 1 }
        when :resource
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

    def inspect
      inspection = %w(value shape dtype).map { |v| "#{v}: #{send(v).inspect}"}
      "#<#{self.class} #{inspection.join(", ")}>"
    end

    def self.finalize(pointer)
      # must use proc instead of stabby lambda
      proc { FFI.TFE_DeleteTensorHandle(pointer) }
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
      tensor = FFI.TFE_TensorHandleResolve(@pointer, @status)
      check_status @status
      FFI.TF_TensorData(tensor)
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
      shape = []
      d = value
      while d.is_a?(Array)
        shape << d.size
        d = d.first
      end
      shape
    end

    # string tensor format
    # https://github.com/tensorflow/tensorflow/blob/5453aee48858fd375172d7ae22fad1557e8557d6/tensorflow/c/tf_tensor.h#L57
    def string_ptr(data)
      start_offset_size = data.size * 8
      offsets = [0]
      data.each do |str|
        offsets << str.bytesize + 1
      end
      data_ptr = ::FFI::MemoryPointer.new(:char, start_offset_size + offsets.pop)
      data_ptr.write_array_of_uint64(offsets)
      data.zip(offsets) do |str, off|
        (data_ptr + start_offset_size + off).write_string(str)
      end
      data_ptr
    end

    def check_status(status)
      Utils.check_status(status)
    end
  end
end
