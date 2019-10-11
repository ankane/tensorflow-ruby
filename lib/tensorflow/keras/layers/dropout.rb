module Tensorflow
  module Keras
    module Layers
      class Dropout
        def initialize(rate)
        end

        def build(input_shape)
          @output_shape = input_shape
        end

        def call(inputs)
          # TODO implement
          Tensorflow.identity(inputs)
        end

        def output_shape
          @output_shape
        end

        def count_params
          0
        end
      end
    end
  end
end
