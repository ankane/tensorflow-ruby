module Tensorflow
  module Keras
    module Layers
      class Flatten
        def initialize(input_shape: nil)
          @input_shape = input_shape
        end

        def output_shape
          flattened_dim = @input_shape.inject(&:*)
          [-1, flattened_dim]
        end

        def count_params
          0
        end

        def call(inputs)
          flattened_dim = inputs.shape[1..-1].inject(&:*)
          Tensorflow.reshape(inputs, [-1, flattened_dim])
        end
      end
    end
  end
end
