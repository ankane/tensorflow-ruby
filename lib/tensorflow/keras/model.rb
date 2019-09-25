module TensorFlow
  module Keras
    class Model
      def trainable_variables
        instance_variables.map { |v| instance_variable_get(v) }.select { |layer| layer.respond_to?(:trainable_variables) }.flat_map { |layer| layer.trainable_variables }
      end
    end
  end
end
