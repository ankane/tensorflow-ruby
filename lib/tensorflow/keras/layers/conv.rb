module Tensorflow
  module Keras
    module Layers
      class Conv
        def initialize(rank, filters, kernel_size, activation: nil)
          @rank = rank
          @filter = filters
          @kernel_size = kernel_size
          @activation = activation
        end
      end
    end
  end
end
