module TensorFlow
  module Keras
    module Metrics
      class Mean
        def initialize(name: nil, dtype: :float)
          @dtype = dtype
          @total = Utils.add_weight(name: "total", initializer: "zeros", dtype: @dtype)
          @count = Utils.add_weight(name: "count", initializer: "zeros", dtype: @dtype)
        end

        def call(values)
          update_state(values)
        end

        def update_state(values)
          input = TensorFlow.convert_to_tensor(values)
          input = TensorFlow.cast(input, @dtype)
          @total.assign_add(Math.reduce_sum(input))
          @count.assign_add(TensorFlow.cast(RawOps.size(input: input), @dtype))
        end

        def result
          RawOps.div_no_nan(x: @total, y: TensorFlow.cast(@count, :float))
        end

        def reset_states
        end
      end
    end
  end
end
