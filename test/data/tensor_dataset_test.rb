require_relative "../test_helper"

module Tensorflow
  module Data
    class TensorDatasetTest < Minitest::Test
      def test_simple
        components = [1,
                      Numo::NArray[1, 2, 3],
                      37]

        dataset = TensorDataset.new(components)
        assert_equal([:int32, :int32 , :int32], dataset.output_types)
        assert_equal([[], [3], []], dataset.output_shapes)
        assert_equal([[1, [1, 2, 3], 37]], dataset.data)
      end
    end
  end
end
