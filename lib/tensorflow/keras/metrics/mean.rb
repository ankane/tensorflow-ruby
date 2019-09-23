module TensorFlow
  module Keras
    module Metrics
      class Mean
        def update_state(values)
          input = TensorFlow.convert_to_tensor(values, dtype: :float)
          @total = Math.reduce_sum(input)
          @count = RawOps.size(input: input)
        end

        def result
          RawOps.div_no_nan(x: @total, y: TensorFlow.cast(@count, :float))
        end
      end
    end
  end
end
