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
        end

        def fit(x, y, epochs: nil)
          puts "Train on %d samples" % [y.size]
          epochs.times do |epoch|
            puts "Epoch #{epoch + 1}/#{epochs}"
          end
        end

        def evaluate(x, y)
          raise "Not implemented"
        end
      end
    end
  end
end
