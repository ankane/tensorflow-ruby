module TensorFlow
  module Keras
    module Layers
      class Dense
        attr_reader :trainable_variables

        def initialize(units, activation: nil, use_bias: true, kernel_initializer: "glorot_uniform", bias_initializer: "zeros", dtype: :float)
          @units = units
          @activation = activation
          @use_bias = use_bias
          @kernel_initializer = kernel_initializer
          @bias_initializer = bias_initializer
          @dtype = dtype
          @built = false
          @trainable_variables = []
        end

        def build(input_shape)
          last_dim = input_shape.last
          @kernel = Utils.add_weight(name: "kernel", shape: [last_dim, @units], initializer: @kernel_initializer, dtype: @dtype)
          @trainable_variables << @kernel

          if @use_bias
            @bias = Utils.add_weight(name: "bias", shape: [@units], initializer: @bias_initializer, dtype: @dtype)
            @trainable_variables << @bias
          else
            @bias = nil
          end

          @built = true
        end

        def call(inputs)
          build(inputs.shape) unless @built

          rank = inputs.shape.size

          if rank > 2
            raise Error, "Rank > 2 not supported yet"
          else
            inputs = TensorFlow.cast(inputs, @dtype)
            outputs = TensorFlow.matmul(inputs, @kernel)
          end

          if @use_bias
            outputs = NN.bias_add(outputs, @bias)
          end

          case @activation
          when "relu"
            NN.relu(outputs)
          when "softmax"
            NN.softmax(outputs)
          when nil
            outputs
          else
            raise "Unknown activation: #{@activation}"
          end
        end
      end
    end
  end
end
