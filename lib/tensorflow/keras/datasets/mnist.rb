module TensorFlow
  module Keras
    module Datasets
      module MNIST
        def self.load_data(path: "mnist.npz")
          # TODO verify hash
          data = Utils.load_dataset(
            path,
            "https://storage.googleapis.com/tensorflow/tf-keras-datasets/mnist.npz"
          )

          [[data["x_train"], data["y_train"]], [data["x_test"], data["y_test"]]]
        end
      end
    end
  end
end
