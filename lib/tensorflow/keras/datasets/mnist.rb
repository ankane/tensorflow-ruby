module TensorFlow
  module Keras
    module Datasets
      module MNIST
        def self.load_data
          # TODO move require
          require "fileutils"
          require "net/http"
          require "tempfile"

          # TODO handle this better
          raise "No HOME" unless ENV["HOME"]
          datasets_dir = "#{ENV["HOME"]}/.keras/datasets"

          FileUtils.mkdir_p(datasets_dir)
          file_path = "#{datasets_dir}/mnist.npz"

          unless File.exist?(file_path)
            url = "https://storage.googleapis.com/tensorflow/tf-keras-datasets/mnist.npz"
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

            FileUtils.mv(temp_path, file_path)
          end

          data = Npy.load_npz(file_path)
          [[data["x_train"], data["y_train"]], [data["x_test"], data["y_test"]]]
        end
      end
    end
  end
end
