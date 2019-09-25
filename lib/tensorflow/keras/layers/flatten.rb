module TensorFlow
  module Keras
    module Layers
      class Flatten
        def initialize(input_shape: nil)
        end

        def call(inputs)
          flattened_dim = inputs.shape[1..-1].inject(&:*)
          TensorFlow.reshape(inputs, [-1, flattened_dim])
        end
      end
    end
  end
end
