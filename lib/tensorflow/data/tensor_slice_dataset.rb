module TensorFlow
  module Data
    class TensorSliceDataset < Dataset
      def initialize(element)
        tensors = Utils.to_tensor_array(element)
        @tensors = tensors # keep reference for memory
        @output_types = tensors.map(&:dtype)
        @output_shapes = tensors.map { |t| t.shape[1..-1] }

        variant_tensor = RawOps.tensor_slice_dataset(components: tensors, output_shapes: @output_shapes)
        super(variant_tensor)
      end
    end
  end
end
