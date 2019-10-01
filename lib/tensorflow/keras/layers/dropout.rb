module TensorFlow
  module Keras
    module Layers
      class Dropout
        def initialize(rate)
        end

        def call(inputs)
          # TODO implement
          TensorFlow.identity(inputs)
        end

        def output_shape
          [] # TODO same as input shape
        end

        def count_params
          0
        end
      end
    end
  end
end
