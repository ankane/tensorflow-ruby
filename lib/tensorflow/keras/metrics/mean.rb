module Tensorflow
  module Keras
    module Metrics
      class Mean
        def initialize(name: nil, dtype: :float)
          @dtype = dtype
          @total = Utils.add_weight(name: "total", initializer: "zeros", dtype: @dtype)
          @count = Utils.add_weight(name: "count", initializer: "zeros", dtype: @dtype)
        end

        def call(*args)
          update_state(*args)
        end

        def update_state(values)
          input = Tensorflow.convert_to_tensor(values)
          input = Tensorflow.cast(input, @dtype)
          @total.assign_add(Math.reduce_sum(input))
          @count.assign_add(Tensorflow.cast(RawOps.size(input: input), @dtype))
        end

        def result
          RawOps.div_no_nan(x: @total, y: Tensorflow.cast(@count, :float))
        end

        def reset_states
        end
      end
    end
  end
end
