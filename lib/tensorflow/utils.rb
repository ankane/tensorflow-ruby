module TensorFlow
  module Utils
    NUMO_TYPE_MAP = {
      int8: Numo::Int8,
      int16: Numo::Int16,
      int32: Numo::Int32,
      int64: Numo::Int64,
      uint8: Numo::UInt8,
      uint16: Numo::UInt16,
      uint32: Numo::UInt32,
      uint64: Numo::UInt64,
      float: Numo::SFloat,
      double: Numo::DFloat
    }

    class << self
      def check_status(status)
        if FFI.TF_GetCode(status) != 0
          raise Error, FFI.TF_Message(status)
        end
      end

      def default_context
        @default_context ||= Context.new
      end

      def execute(op_name, inputs = [], **attrs)
        context = default_context
        status = FFI.TF_NewStatus # TODO reuse status between ops?
        op = FFI.TFE_NewOp(context, op_name, status)
        check_status status

        attrs.each do |attr_name, attr_value|
          next if attr_value.nil?

          attr_name = attr_name.to_s

          is_list = ::FFI::MemoryPointer.new(:int)
          type = FFI.TFE_OpGetAttrType(op, attr_name, is_list, status)
          check_status status

          if is_list.read_int == 1
            case FFI::AttrType[type]
            when :shape
              num_values = attr_value.size
              dims_ptrs =
                attr_value.map do |shape|
                  ptr = ::FFI::MemoryPointer.new(:int64, shape.size)
                  ptr.write_array_of_int64(shape)
                end
              dims = ::FFI::MemoryPointer.new(:pointer, num_values)
              dims.write_array_of_pointer(dims_ptrs)

              num_dims = ::FFI::MemoryPointer.new(:int, num_values)
              num_dims.write_array_of_int(attr_value.map(&:size))

              FFI.TFE_OpSetAttrShapeList(op, attr_name, dims, num_dims, num_values, status)
            when :type
              num_values = attr_value.size
              values = ::FFI::MemoryPointer.new(:int, num_values)
              types =
                attr_value.map do |v|
                  if v.is_a?(Symbol)
                    FFI::DataType[v]
                  else
                    v
                  end
                end
              values.write_array_of_int(types)
              FFI.TFE_OpSetAttrTypeList(op, attr_name, values, num_values)
            else
              raise "Unknown list type: #{FFI::AttrType[type]}"
            end
          else
            case FFI::AttrType[type]
            when :string
              FFI.TFE_OpSetAttrString(op, attr_name, attr_value, attr_value.bytesize)
            when :int
              FFI.TFE_OpSetAttrInt(op, attr_name, attr_value)
            when :float
              FFI.TFE_OpSetAttrFloat(op, attr_name, attr_value)
            when :bool
              FFI.TFE_OpSetAttrBool(op, attr_name, attr_value ? 1 : 0)
            when :type
              attr_value = FFI::DataType[attr_value] if attr_value.is_a?(Symbol)
              FFI.TFE_OpSetAttrType(op, attr_name, attr_value)
            when :shape
              # TODO set value properly
              FFI.TFE_OpSetAttrShape(op, attr_name, nil, 0, status)
              check_status status
            # when :tensor
            # when :placeholder
            # when :func
            else
              raise "Unknown type: #{FFI::AttrType[type]}"
            end
          end
        end

        inputs.each_with_index do |input, i|
          # TODO handle this better
          if op_name == "TensorSliceDataset" && i == 0
            input =
              input.map do |inp|
                if inp.respond_to?(:to_ptr)
                  inp
                else
                  TensorFlow.convert_to_tensor(inp)
                end
              end

            input_ptr = ::FFI::MemoryPointer.new(:pointer, input.size)
            input_ptr.write_array_of_pointer(input)
            FFI.TFE_OpAddInputList(op, input_ptr, input.size, status)
          else
            raise "Missing argument" if input.nil?

            input = TensorFlow.convert_to_tensor(input) unless input.respond_to?(:to_ptr)
            FFI.TFE_OpAddInput(op, input, status)
          end
          check_status status
        end

        retvals = ::FFI::MemoryPointer.new(:pointer, 2)
        num_retvals = ::FFI::MemoryPointer.new(:int)
        num_retvals.write_int(retvals.size)
        FFI.TFE_Execute(op, retvals, num_retvals, status)
        check_status status

        n = num_retvals.read_int
        if n > 0
          retvals =
            retvals.read_array_of_pointer(n).map do |handle|
              type = FFI.TFE_TensorHandleDataType(handle)

              case FFI::DataType[type]
              when :resource, :variant
                handle
              else
                Tensor.new(pointer: handle)
              end
            end

          n == 1 ? retvals.first : retvals
        end
      ensure
        FFI.TF_DeleteStatus(status) if status
        FFI.TFE_DeleteOp(op) if op
      end

      def infer_type(value)
        if value.is_a?(Numo::NArray)
          type = NUMO_TYPE_MAP.find { |k, v| value.is_a?(v) }
          if type
            type.first
          else
            raise Error, "Unable to infer data type"
          end
        elsif value.empty?
          raise Error, "Unable to infer data type"
        elsif value.all? { |v| v.is_a?(String) }
          :string
        elsif value.all? { |v| v.is_a?(TrueClass) || v.is_a?(FalseClass) }
          :bool
        elsif value.all? { |v| v.is_a?(Integer) }
          if value.all? { |v| v >= -2147483648 && v <= 2147483647 }
            :int32
          else
            :int64
          end
        elsif value.all? { |v| v.is_a?(Complex) }
          :complex128
        elsif value.all? { |v| v.is_a?(Numeric) }
          :float
        else
          raise Error, "Unable to infer data type"
        end
      end

      def to_tensor_array(values)
        values.map do |v|
          if v.is_a?(Tensor)
            v
          else
            TensorFlow.convert_to_tensor(v)
          end
        end
      end

      def datasets_path
        # TODO handle this better
        raise "No HOME" unless ENV["HOME"]
        datasets_dir = "#{ENV["HOME"]}/.keras/datasets"
      end

      def load_dataset(path, url, file_hash = nil)
        FileUtils.mkdir_p(datasets_path)

        path = "#{datasets_path}/#{path}"
        Utils.download_file(url, path, file_hash) unless File.exist?(path)

        if url.end_with?(".json")
          JSON.parse(File.read(path))
        else
          Npy.load_npz(path)
        end
      end

      def download_file(url, dest, file_hash = nil)
        uri = URI(url)

        temp_dir ||= File.dirname(Tempfile.new("tensorflow"))
        temp_path = "#{temp_dir}/#{Time.now.to_f}" # TODO better name

        digest = file_hash&.size == 32 ? Digest::MD5.new : Digest::SHA2.new

        # Net::HTTP automatically adds Accept-Encoding for compression
        # of response bodies and automatically decompresses gzip
        # and deflateresponses unless a Range header was sent.
        # https://ruby-doc.org/stdlib-2.6.4/libdoc/net/http/rdoc/Net/HTTP.html
        Net::HTTP.start(uri.host, uri.port, use_ssl: true) do |http|
          request = Net::HTTP::Get.new(uri)

          puts "Downloading data from #{url}"
          i = 0
          File.open(temp_path, "wb") do |f|
            http.request(request) do |response|
              response.read_body do |chunk|
                f.write(chunk)
                digest.update(chunk)

                # print progress
                putc "." if i % 50 == 0
                i += 1
              end
            end
            puts # newline
          end
        end

        if file_hash && digest.hexdigest != file_hash
          raise Error, "Bad hash"
        end

        FileUtils.mv(temp_path, dest)
      end
    end
  end
end
