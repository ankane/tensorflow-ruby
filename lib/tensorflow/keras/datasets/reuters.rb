module TensorFlow
  module Keras
    module Datasets
      module Reuters
        # unfortunately, npy can't read pickle and numo can't store objects
        # def self.load_data(path: "reuters.npz", test_split: 0.2, seed: 113)
        #   data = Utils.load_dataset(
        #     path,
        #     "https://storage.googleapis.com/tensorflow/tf-keras-datasets/reuters.npz",
        #     "d6586e694ee56d7a4e65172e12b3e987c03096cb01eab99753921ef915959916"
        #   )

        #   xs = data["x"]
        #   labels = data["y"]
        # end

        def self.get_word_index(path: "reuters_word_index.json")
          file = Utils.get_file(
            path,
            "https://storage.googleapis.com/tensorflow/tf-keras-datasets/reuters_word_index.json",
            file_hash: "4d44cc38712099c9e383dc6e5f11a921"
          )
          JSON.parse(File.read(file))
        end
      end
    end
  end
end
