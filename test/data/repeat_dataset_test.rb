require_relative "../test_helper"

module Tensorflow
  module Data
    class RepeatDatasetTest < Minitest::Test
      def test_simple
        components = [1,
                      Numo::NArray[1, 2, 3],
                      37]

        dataset = TensorDataset.new(components).repeat(3)
        assert_equal([[1, [1, 2, 3], 37], [1, [1, 2, 3], 37], [1, [1, 2, 3], 37]], dataset.data)
      end
    end
  end
end
