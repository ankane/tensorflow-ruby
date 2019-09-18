module TensorFlow
  module Keras
    module Models
      class Sequential
        def initialize(layers = [])
          @layers = []

          layers.each do |layer|
            add(layer)
          end
        end

        def add(layer)
          @layers << layer
        end

        def compile(optimizer: nil, loss: nil, metrics: nil)
          raise "Not implemented"
        end

        def fit(x, y, epochs: nil)
          raise "Not implemented"
        end

        def evaluate(x, y)
          raise "Not implemented"
        end
      end
    end
  end
end
