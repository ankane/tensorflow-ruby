module TensorFlow
  module Utils
    def self.check_status(status)
      if FFI.TF_GetCode(status) != 0
        raise Error, FFI.TF_Message(status)
      end
    end

    def self.infer_type(value)
      if value.all? { |v| v.is_a?(String) }
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

    def self.load_dataset(path, url)
      # TODO handle this better
      raise "No HOME" unless ENV["HOME"]
      datasets_dir = "#{ENV["HOME"]}/.keras/datasets"
      FileUtils.mkdir_p(datasets_dir)

      path = "#{datasets_dir}/#{path}"
      Utils.download_file(url, path) unless File.exist?(path)
      Npy.load_npz(path)
    end

    def self.download_file(url, dest)
      uri = URI(url)

      temp_dir ||= File.dirname(Tempfile.new("tensorflow"))
      temp_path = "#{temp_dir}/#{Time.now.to_f}" # TODO better name

      # Net::HTTP automatically adds Accept-Encoding for compression
      # of response bodies and automatically decompresses gzip
      # and deflateresponses unless a Range header was sent.
      # https://ruby-doc.org/stdlib-2.6.4/libdoc/net/http/rdoc/Net/HTTP.html
      Net::HTTP.start(uri.host, uri.port, use_ssl: true) do |http|
        request = Net::HTTP::Get.new(uri)

        print("Downloading dataset")
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
