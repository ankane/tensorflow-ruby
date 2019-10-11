module Tensorflow
  module IO
    class << self
      def decode_and_crop_jpeg(contents, crop_window, channels: nil, ratio: nil, fancy_upscaling: nil, try_recover_truncated: nil, acceptable_fraction: nil, dct_method: nil)
        RawOps.decode_and_crop_jpeg(contents: contents, crop_window: crop_window, channels: channels, ratio: ratio, fancy_upscaling: fancy_upscaling, try_recover_truncated: try_recover_truncated, acceptable_fraction: acceptable_fraction, dct_method: dct_method)
      end

      def decode_base64(input)
        RawOps.decode_base64(input: input)
      end

      def decode_bmp(contents, channels: nil)
        RawOps.decode_bmp(contents: contents, channels: channels)
      end

      def decode_compressed(bytes, compression_type: nil)
        RawOps.decode_compressed(bytes: bytes, compression_type: compression_type)
      end

      def decode_csv(records, record_defaults, field_delim: nil, use_quote_delim: nil, na_value: nil, select_cols: nil)
        RawOps.decode_csv(records: records, record_defaults: record_defaults, field_delim: field_delim, use_quote_delim: use_quote_delim, na_value: na_value, select_cols: select_cols)
      end

      def decode_gif(contents)
        RawOps.decode_gif(contents: contents)
      end

      # def decode_image
      # end

      def decode_jpeg(contents, channels: nil, ratio: nil, fancy_upscaling: nil, try_recover_truncated: nil, acceptable_fraction: nil, dct_method: nil)
        RawOps.decode_jpeg(contents: contents, channels: channels, ratio: ratio, fancy_upscaling: fancy_upscaling, try_recover_truncated: try_recover_truncated, acceptable_fraction: acceptable_fraction, dct_method: dct_method)
      end

      def decode_json_example(json_examples)
        RawOps.decode_json_example(json_examples: json_examples)
      end

      def decode_png(contents, channels: nil, dtype: nil)
        RawOps.decode_png(contents: contents, channels: channels, dtype: dtype)
      end

      # def decode_proto
      # end

      def decode_raw(bytes, out_type: nil, little_endian: nil)
        RawOps.decode_raw(bytes: bytes, out_type: out_type, little_endian: little_endian)
      end

      def deserialize_many_sparse(serialized_sparse, dtype: nil)
        RawOps.deserialize_many_sparse(serialized_sparse: serialized_sparse, dtype: dtype)
      end

      def encode_base64(input, pad: nil)
        RawOps.encode_base64(input: input, pad: pad)
      end

      def encode_jpeg(image, format: nil, quality: nil, progressive: nil, optimize_size: nil, chroma_downsampling: nil, density_unit: nil, x_density: nil, y_density: nil, xmp_metadata: nil)
        RawOps.encode_jpeg(image: image, format: format, quality: quality, progressive: progressive, optimize_size: optimize_size, chroma_downsampling: chroma_downsampling, density_unit: density_unit, x_density: x_density, y_density: y_density, xmp_metadata: xmp_metadata)
      end

      def encode_proto(sizes, values, field_names: nil, message_type: nil, descriptor_source: nil)
        RawOps.encode_proto(sizes: sizes, values: values, field_names: field_names, message_type: message_type, descriptor_source: descriptor_source)
      end

      def extract_jpeg_shape(contents, output_type: nil)
        RawOps.extract_jpeg_shape(contents: contents, output_type: output_type)
      end

      def is_jpeg(contents)
        Image.is_jpeg(contents)
      end

      # def match_filenames_once
      # end

      def matching_files(pattern)
        RawOps.matching_files(pattern: pattern)
      end

      def parse_example(serialized, names, sparse_keys, dense_keys, dense_defaults, sparse_types: nil, dense_shapes: nil)
        RawOps.parse_example(serialized: serialized, names: names, sparse_keys: sparse_keys, dense_keys: dense_keys, dense_defaults: dense_defaults, sparse_types: sparse_types, dense_shapes: dense_shapes)
      end

      def parse_sequence_example(serialized, debug_name, context_dense_defaults, feature_list_dense_missing_assumed_empty: nil, context_sparse_keys: nil, context_dense_keys: nil, feature_list_sparse_keys: nil, feature_list_dense_keys: nil, context_sparse_types: nil, feature_list_dense_types: nil, context_dense_shapes: nil, feature_list_sparse_types: nil, feature_list_dense_shapes: nil)
        RawOps.parse_sequence_example(serialized: serialized, debug_name: debug_name, context_dense_defaults: context_dense_defaults, feature_list_dense_missing_assumed_empty: feature_list_dense_missing_assumed_empty, context_sparse_keys: context_sparse_keys, context_dense_keys: context_dense_keys, feature_list_sparse_keys: feature_list_sparse_keys, feature_list_dense_keys: feature_list_dense_keys, context_sparse_types: context_sparse_types, feature_list_dense_types: feature_list_dense_types, context_dense_shapes: context_dense_shapes, feature_list_sparse_types: feature_list_sparse_types, feature_list_dense_shapes: feature_list_dense_shapes)
      end

      def parse_single_example(serialized, dense_defaults, num_sparse: nil, sparse_keys: nil, dense_keys: nil, sparse_types: nil, dense_shapes: nil)
        RawOps.parse_single_example(serialized: serialized, dense_defaults: dense_defaults, num_sparse: num_sparse, sparse_keys: sparse_keys, dense_keys: dense_keys, sparse_types: sparse_types, dense_shapes: dense_shapes)
      end

      def parse_single_sequence_example(serialized, feature_list_dense_missing_assumed_empty, context_sparse_keys, context_dense_keys, feature_list_sparse_keys, feature_list_dense_keys, context_dense_defaults, debug_name, context_sparse_types: nil, feature_list_dense_types: nil, context_dense_shapes: nil, feature_list_sparse_types: nil, feature_list_dense_shapes: nil)
        RawOps.parse_single_sequence_example(serialized: serialized, feature_list_dense_missing_assumed_empty: feature_list_dense_missing_assumed_empty, context_sparse_keys: context_sparse_keys, context_dense_keys: context_dense_keys, feature_list_sparse_keys: feature_list_sparse_keys, feature_list_dense_keys: feature_list_dense_keys, context_dense_defaults: context_dense_defaults, debug_name: debug_name, context_sparse_types: context_sparse_types, feature_list_dense_types: feature_list_dense_types, context_dense_shapes: context_dense_shapes, feature_list_sparse_types: feature_list_sparse_types, feature_list_dense_shapes: feature_list_dense_shapes)
      end

      def parse_tensor(serialized, out_type: nil)
        RawOps.parse_tensor(serialized: serialized, out_type: out_type)
      end

      def read_file(filename)
        RawOps.read_file(filename: filename)
      end

      def serialize_many_sparse(sparse_indices, sparse_values, sparse_shape, out_type: nil)
        RawOps.serialize_many_sparse(sparse_indices: sparse_indices, sparse_values: sparse_values, sparse_shape: sparse_shape, out_type: out_type)
      end

      def serialize_sparse(sparse_indices, sparse_values, sparse_shape, out_type: nil)
        RawOps.serialize_sparse(sparse_indices: sparse_indices, sparse_values: sparse_values, sparse_shape: sparse_shape, out_type: out_type)
      end

      def serialize_tensor(tensor)
        RawOps.serialize_tensor(tensor: tensor)
      end

      def write_file(filename, contents)
        RawOps.write_file(filename: filename, contents: contents)
      end

      # def write_graph
      # end
    end
  end
end
