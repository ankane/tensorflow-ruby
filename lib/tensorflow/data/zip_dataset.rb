module Tensorflow
  module Data
    class ZipDataset < Dataset
      def initialize(*datasets)
        datasets = datasets.flatten(1)
        tensors = Array.new(datasets.size)
        output_types = Array.new(datasets.size)
        output_shapes = Array.new(datasets.size)

        datasets.each_with_index do |dataset, i|
          tensors[i] = dataset.variant_tensor
          output_types[i] = dataset.output_types
          output_shapes[i] = dataset.output_shapes
        end

        @output_types = output_types.flatten
        @output_shapes = output_shapes.flatten(1)
        variant_tensor = RawOps.zip_dataset(
            input_datasets: tensors,
            output_types: @output_types,
            output_shapes: @output_shapes)

        super(variant_tensor)
      end
    end
  end
end
