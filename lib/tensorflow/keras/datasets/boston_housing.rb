module TensorFlow
  module Keras
    module Datasets
      module BostonHousing
        def self.load_data(path: "boston_housing.npz", test_split: 0.2, seed: 113)
          # TODO verify hash
          data = Utils.load_dataset(
            path,
            "https://storage.googleapis.com/tensorflow/tf-keras-datasets/boston_housing.npz",
            "f553886a1f8d56431e820c5b82552d9d95cfcb96d1e678153f8839538947dff5"
          )

          x = data["x"]
          y = data["y"]

          len = x.shape[0]
          indices = (0...len).to_a.shuffle(random: Random.new(seed))
          x = x[indices, true]
          y = y[indices]

          x_train = x[0...(len * (1 - test_split)), true]
          y_train = y[0...(len * (1 - test_split))]
          x_test = x[(len * (1 - test_split))..-1, true]
          y_test = y[(len * (1 - test_split))..-1]

          [[x_train, y_train], [x_test, y_test]]
        end
      end
    end
  end
end
