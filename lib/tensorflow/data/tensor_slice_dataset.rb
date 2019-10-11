module Tensorflow
  module Data
    class TensorSliceDataset < Dataset
      def initialize(elements)
        # keep reference for memory
        @tensors = Utils.to_tensor_array(elements)
        @output_types = @tensors.map(&:dtype)
        @output_shapes = @tensors.map do |tensor|
          tensor.shape[1..]
        end

        variant_tensor = RawOps.tensor_slice_dataset(components: @tensors, output_shapes: @output_shapes)
        super(variant_tensor)
      end
    end
  end
end
