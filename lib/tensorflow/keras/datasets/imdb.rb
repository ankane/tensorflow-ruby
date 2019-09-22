module TensorFlow
  module Keras
    module Datasets
      module IMDB
        # unfortunately, npy can't read pickle and numo can't store objects
        # def self.load_data(path: "imdb.npz", seed: 113)
        #   data = Utils.load_dataset(
        #     path,
        #     "https://storage.googleapis.com/tensorflow/tf-keras-datasets/imdb.npz",
        #     "69664113be75683a8fe16e3ed0ab59fda8886cb3cd7ada244f7d9544e4676b9f"
        #   )

        #   x_train = data["x_train"]
        #   labels_train = data["y_train"]
        #   x_test = data["x_test"]
        #   labels_test = data["y_test"]
        # end

        def self.get_word_index(path: "imdb_word_index.json")
          Utils.load_dataset(
            path,
            "https://storage.googleapis.com/tensorflow/tf-keras-datasets/imdb_word_index.json",
            "bfafd718b763782e994055a2d397834f"
          )
        end
      end
    end
  end
end
