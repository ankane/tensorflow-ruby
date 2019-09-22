module TensorFlow
  module Keras
    module Datasets
      module Reuters
        def self.get_word_index(path: "reuters_word_index.json")
          Utils.load_dataset(
            path,
            "https://storage.googleapis.com/tensorflow/tf-keras-datasets/reuters_word_index.json"
          )
        end
      end
    end
  end
end
