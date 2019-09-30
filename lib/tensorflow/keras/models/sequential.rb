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

            samples_width = sample_size.to_s.size
            title = "%#{samples_width}d/#{sample_size}" % [1]
            progressbar = ProgressBar.create(total: sample_size, length: 30 + 3 + title.size, format: "%t [%B]", remainder_mark: ".")
            sample_size.times do |i|
              progressbar.title = "%#{samples_width}d/#{sample_size}" % [i + 1]
              progressbar.increment
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
