module TensorFlow
  module Keras
    module Layers
      class Conv2D < Conv
        def initialize(filters, kernel_size, activation: nil)
          super(2, filters, kernel_size, activation: activation)
        end
      end
    end
  end
end
