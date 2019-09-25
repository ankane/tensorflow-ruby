module TensorFlow
  module Keras
    module Losses
      class SparseCategoricalCrossentropy
        def call(target, output)
          output = Math.log(output)
          target = TensorFlow.cast(target, :int64)
          cost, _ = RawOps.sparse_softmax_cross_entropy_with_logits(features: output, labels: target)
          Math.reduce_sum(cost) / TensorFlow.cast(RawOps.size(input: cost), :float)
        end
      end
    end
  end
end
