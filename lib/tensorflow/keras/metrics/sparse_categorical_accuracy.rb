module Tensorflow
  module Keras
    module Metrics
      class SparseCategoricalAccuracy < Mean
        def update_state(y_true, y_pred)
          y_true = Tensorflow.convert_to_tensor(y_true)
          y_pred = Tensorflow.convert_to_tensor(y_pred)

          y_pred = RawOps.arg_max(input: y_pred, dimension: -1)

          if y_pred.dtype != y_true.dtype
            y_pred = Tensorflow.cast(y_pred, y_true.dtype)
          end

          super(Math.equal(y_true, y_pred))
        end
      end
    end
  end
end
