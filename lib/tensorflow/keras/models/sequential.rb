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
          @optimizer =
            case optimizer
            when "adam"
              Optimizers::Adam.new
            else
              raise "Unknown optimizer: #{optimizer}"
            end

          @loss =
            case loss
            when "sparse_categorical_crossentropy"
              Losses::SparseCategoricalCrossentropy.new
            else
              raise "Unknown loss: #{loss}"
            end

          @metrics =
            metrics.map do |metric|
              case metric
              when "accuracy"
                Metrics::SparseCategoricalAccuracy.new
              else
                raise "Unknown metric: #{metric}"
              end
            end
        end

        def fit(x, y, epochs: nil)
          sample_size = y.size
          puts "Train on %d samples" % [sample_size]
          epochs.times do |epoch|
            puts "Epoch #{epoch + 1}/#{epochs}"

            current_batch_size = 32
            dataset = Data::Dataset.from_tensor_slices([x, y]).batch(current_batch_size)

            samples_width = sample_size.to_s.size
            title = "%#{samples_width}d/#{sample_size}" % [0]
            progressbar = ProgressBar.create(total: sample_size, length: 47 + title.size, format: "%t [%B] %e", remainder_mark: ".")

            dataset.each do |inputs, labels|
              progressbar.title = "%#{samples_width}d/#{sample_size}" % [progressbar.progress + current_batch_size]
              progressbar.progress += current_batch_size
            end

            reset_metrics
          end
        end

        def evaluate(x, y)
          raise "Not implemented"
        end

        private

        def reset_metrics
          @metrics.each(&:reset_states)
        end
      end
    end
  end
end
