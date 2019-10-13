module Tensorflow
  module Data
    class RepeatDataset < Dataset
      def initialize(dataset, count)
        @output_types = dataset.output_types
        @output_shapes = dataset.output_shapes

        variant_tensor = RawOps.repeat_dataset(
            input_dataset: dataset,
            count: Tensor.new(count, dtype: :int64),
            output_types: @output_types,
            output_shapes: @output_shapes)

        super(variant_tensor)
      end
    end
  end
end
