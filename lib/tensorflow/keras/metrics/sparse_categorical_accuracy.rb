module TensorFlow
  module Keras
    module Metrics
      class SparseCategoricalAccuracy < Mean
        def call(y_true, y_pred)
          update_state(y_true, y_pred)
        end

        def update_state(y_true, y_pred)
          y_true = TensorFlow.convert_to_tensor(y_true)
          y_pred = TensorFlow.convert_to_tensor(y_pred)

          y_pred = RawOps.arg_max(input: y_pred, dimension: -1)

          if y_pred.dtype != y_true.dtype
            y_pred = TensorFlow.cast(y_pred, y_true.dtype)
          end

          super(Math.equal(y_true, y_pred))
        end
      end
    end
  end
end
