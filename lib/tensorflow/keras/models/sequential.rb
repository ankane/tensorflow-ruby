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

        def summary
          sep = "_________________________________________________________________\n"
          total_params = @layers.map(&:count_params).sum

          summary = String.new("")
          summary << "Model: \"sequential\"\n"
          summary << sep
          summary << "Layer (type)                 Output Shape              Param #   \n"
          summary << "=================================================================\n"
          summary << @layers.map { |l| "%-28s %-25s %-10s\n" % [l.class.name.split("::").last, l.output_shape.map { |v| v == -1 ? nil : v }.inspect, l.count_params] }.join(sep)
          summary << "=================================================================\n"
          summary << "Total params: #{total_params}\n"
          summary << "Trainable params: #{total_params}\n"
          summary << "Non-trainable params: 0\n"
          summary << sep
          puts summary
        end
      end
    end
  end
end
