module TensorFlow
  module Keras
    module Datasets
      module IMDB
        def self.get_word_index(path: "imdb_word_index.json")
          Utils.load_dataset(
            path,
            "https://storage.googleapis.com/tensorflow/tf-keras-datasets/imdb_word_index.json"
          )
        end
      end
    end
  end
end
