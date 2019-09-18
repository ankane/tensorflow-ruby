module TensorFlow
  module Utils
    def self.check_status(status)
      if FFI.TF_GetCode(status) != 0
        raise Error, FFI.TF_Message(status)
      end
    end

    def self.infer_type(value)
      case value
      when String
        :string
      when Float
        :float
      when true, false
        :bool
      else
        :int32
      end
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

        print("Downloading MNIST")
        i = 0
        File.open(temp_path, "wb") do |f|
          http.request(request) do |response|
            response.read_body do |chunk|
              putc "." if i % 50 == 0
              f.write(chunk)
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
