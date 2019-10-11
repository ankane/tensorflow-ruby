module Tensorflow
  module Data
    class MapDataset < Dataset
      # REGISTER_OP("MapDataset")
      #     .Input("input_dataset: variant")
      #     .Input("other_arguments: Targuments")
      #     .Output("handle: variant")
      #     .Attr("f: func")
      #     .Attr("Targuments: list(type) >= 0")
      #     .Attr("output_types: list(type) >= 1")
      #     .Attr("output_shapes: list(shape) >= 1")
      #     .Attr("use_inter_op_parallelism: bool = true")
      #     .Attr("preserve_cardinality: bool = false")
      #     .SetShapeFn(shape_inference::ScalarShape);

      def initialize(input_dataset, block, other_arguments: nil, output_types: nil, output_shapes: nil, use_inter_op_parallelism: nil, preserve_cardinality: nil)
        variant_tensor = RawOps.map_dataset(input_dataset: input_dataset.variant_tensor,
                                            other_arguments: other_arguments,
                                            f: block,
                                            output_types: output_types,
                                            output_shapes: output_shapes,
                                            use_inter_op_parallelism: use_inter_op_parallelism,
                                            preserve_cardinality: preserve_cardinality)

        super(variant_tensor)
      end
    end
  end
end
