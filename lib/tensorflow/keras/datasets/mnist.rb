module TensorFlow
  module Keras
    module Datasets
      module MNIST
        def self.load_data(path: "mnist.npz")
          data = Utils.load_dataset(
            path,
            "https://storage.googleapis.com/tensorflow/tf-keras-datasets/mnist.npz",
            "731c5ac602752760c8e48fbffcf8c3b850d9dc2a2aedcf2cc48468fc17b673d1"
          )

          [[data["x_train"], data["y_train"]], [data["x_test"], data["y_test"]]]
        end
      end
    end
  end
end
