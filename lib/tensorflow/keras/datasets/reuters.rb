module TensorFlow
  module Keras
    module Datasets
      module Reuters
        # def self.load_data
        # end

        def self.get_word_index(path: "reuters_word_index.json")
          Utils.load_dataset(
            path,
            "https://storage.googleapis.com/tensorflow/tf-keras-datasets/reuters_word_index.json",
            "4d44cc38712099c9e383dc6e5f11a921"
          )
        end
      end
    end
  end
end
