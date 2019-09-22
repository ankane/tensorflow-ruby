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

        inputs.each do |input|
          input = TensorFlow.convert_to_tensor(input) unless input.respond_to?(:to_ptr)
          FFI.TFE_OpAddInput(op, input, status)
          check_status status
        end

        retvals = ::FFI::MemoryPointer.new(:pointer)
        num_retvals = ::FFI::MemoryPointer.new(:int)
        num_retvals.write_int(retvals.size)
        FFI.TFE_Execute(op, retvals, num_retvals, status)
        check_status status

        if num_retvals.read_int > 0
          handle = retvals.read_pointer
          type = FFI.TFE_TensorHandleDataType(handle)

          case FFI::DataType[type]
          when :resource
            handle
          else
            Tensor.new(pointer: handle)
          end
        end
      ensure
        FFI.TF_DeleteStatus(status) if status
        FFI.TFE_DeleteOp(op) if op
      end

      def infer_type(value)
        if value.is_a?(Numo::NArray) && (type = NUMO_TYPE_MAP.find { |k, v| value.is_a?(v) })
          type.first
        elsif value.all? { |v| v.is_a?(String) }
          :string
        elsif value.all? { |v| v == true || v == false }
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

      def load_dataset(path, url)
        # TODO handle this better
        raise "No HOME" unless ENV["HOME"]
        datasets_dir = "#{ENV["HOME"]}/.keras/datasets"
        FileUtils.mkdir_p(datasets_dir)

        path = "#{datasets_dir}/#{path}"
        Utils.download_file(url, path) unless File.exist?(path)
        Npy.load_npz(path)
      end

      def download_file(url, dest)
        uri = URI(url)

        temp_dir ||= File.dirname(Tempfile.new("tensorflow"))
        temp_path = "#{temp_dir}/#{Time.now.to_f}" # TODO better name

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

                # print progress
                putc "." if i % 50 == 0
                i += 1
              end
            end
            puts # newline
          end
        end

        FileUtils.mv(temp_path, dest)
      end
    end
  end
end
