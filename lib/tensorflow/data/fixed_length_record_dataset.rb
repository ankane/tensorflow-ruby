module Tensorflow
  module Data
    class FixedLengthRecordDataset < Dataset
      def initialize(filenames, record_bytes, header_bytes: 0, footer_bytes: 0, buffer_size: DEFAULT_READER_BUFFER_SIZE_BYTES, compression_type: '')
        @output_types = [:string]
        @output_shapes = [[]]
        variant_tensor = RawOps.fixed_length_record_dataset_v2(
            filenames: filenames,
            record_bytes: Tensorflow.convert_to_tensor(record_bytes, dtype: :int64),
            header_bytes: Tensorflow.convert_to_tensor(header_bytes, dtype: :int64),
            footer_bytes: Tensorflow.convert_to_tensor(footer_bytes, dtype: :int64),
            buffer_size: Tensorflow.convert_to_tensor(buffer_size, dtype: :int64),
            compression_type: compression_type)

        super(variant_tensor)
      end
    end
  end
end
