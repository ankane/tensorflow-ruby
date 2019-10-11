module Tensorflow
  module Data
    class ZipDataset < Dataset
      def initialize(*datasets)
        tensors = datasets.flatten.map do |dataset|
          dataset.variant_tensor
        end

        output_types = Array.new
        output_shapes = Array.new
        variant_tensor = RawOps.zip_dataset(
            input_datasets: tensors,
            output_types: nil,
            output_shapes: nil)
        super(variant_tensor)
      end
    end
  end
end
