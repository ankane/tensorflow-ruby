module TensorFlow
  module Data
    class ShuffleDataset < Dataset
      def initialize(input_dataset, buffer_size)
        @output_types = input_dataset.output_types
        @output_shapes = input_dataset.output_shapes

        variant_tensor = RawOps.shuffle_dataset(
          input_dataset: input_dataset,
          buffer_size: TensorFlow.convert_to_tensor(buffer_size, dtype: :int64),
          seed: TensorFlow.convert_to_tensor(0, dtype: :int64),
          seed2: TensorFlow.convert_to_tensor(0, dtype: :int64),
          output_types: @output_types,
          output_shapes: @output_shapes
        )
        super(variant_tensor)
      end
    end
  end
end
