module TensorFlow
  module Keras
    module Utils
      class << self
        def get_file(fname, origin, file_hash: nil, cache_subdir: "datasets")
          # destination
          # TODO handle this better
          raise "No HOME" unless ENV["HOME"]
          dest = "#{ENV["HOME"]}/.keras/#{cache_subdir}/#{fname}"
          FileUtils.mkdir_p(File.dirname(dest))

          return dest if File.exist?(dest)

          temp_dir ||= File.dirname(Tempfile.new("tensorflow"))
          temp_path = "#{temp_dir}/#{Time.now.to_f}" # TODO better name

          digest = file_hash&.size == 32 ? Digest::MD5.new : Digest::SHA2.new

          uri = URI(origin)

          # Net::HTTP automatically adds Accept-Encoding for compression
          # of response bodies and automatically decompresses gzip
          # and deflateresponses unless a Range header was sent.
          # https://ruby-doc.org/stdlib-2.6.4/libdoc/net/http/rdoc/Net/HTTP.html
          Net::HTTP.start(uri.host, uri.port, use_ssl: true) do |http|
            request = Net::HTTP::Get.new(uri)

            puts "Downloading data from #{origin}"
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

          dest
        end
      end
    end
  end
end
