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
          sample_size = y.size
          puts "Train on %d samples" % [sample_size]
          epochs.times do |epoch|
            puts "Epoch #{epoch + 1}/#{epochs}"

            title = "Progress"
            progressbar = ProgressBar.create(total: sample_size, length: 30 + 4 + title.size, format: "%t: [%B]", remainder_mark: ".")
            sample_size.times do
              progressbar.increment
              # sleep(0.001)
            end
          end
        end

        def evaluate(x, y)
          raise "Not implemented"
        end
      end
    end
  end
end
