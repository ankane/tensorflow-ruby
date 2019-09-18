module TensorFlow
  module Keras
    module Datasets
      module MNIST
        def self.load_data
          # TODO handle this better
          raise "No HOME" unless ENV["HOME"]
          datasets_dir = "#{ENV["HOME"]}/.keras/datasets"
          FileUtils.mkdir_p(datasets_dir)

          url = "https://storage.googleapis.com/tensorflow/tf-keras-datasets/mnist.npz"
          path = "#{datasets_dir}/mnist.npz"
          Utils.download_file(url, path) unless File.exist?(path)

          data = Npy.load_npz(path)
          [[data["x_train"], data["y_train"]], [data["x_test"], data["y_test"]]]
        end
      end
    end
  end
end
