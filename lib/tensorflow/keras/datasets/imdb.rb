module TensorFlow
  module Keras
    module Datasets
      module IMDB
        # def self.load_data
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
