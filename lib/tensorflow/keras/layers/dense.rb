module Tensorflow
  module Keras
    module Layers
      class Dense
        def initialize(units, activation: nil, use_bias: true, kernel_initializer: "glorot_uniform", bias_initializer: "zeros", dtype: :float)
          @units = units
          @activation = activation
          @use_bias = use_bias
          @kernel_initializer = kernel_initializer
          @bias_initializer = bias_initializer
          @dtype = dtype
          @built = false
        end

        def build(input_shape)
          last_dim = input_shape.last
          @kernel = Utils.add_weight(name: "kernel", shape: [last_dim, @units], initializer: @kernel_initializer, dtype: @dtype)

          if @use_bias
            @bias = Utils.add_weight(name: "bias", shape: [@units], initializer: @bias_initializer, dtype: @dtype)
          else
            @bias = nil
          end

          @output_shape = [last_dim, @units]

          @built = true
        end

        def output_shape
          @output_shape
        end

        def count_params
          @units + @kernel.shape.inject(&:*)
        end

        def call(inputs)
          build(inputs.shape) unless @built

          rank = inputs.shape.size

          if rank > 2
            raise Error, "Rank > 2 not supported yet"
          else
            inputs = Tensorflow.cast(inputs, @dtype)
            outputs = Tensorflow.matmul(inputs, @kernel)
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
