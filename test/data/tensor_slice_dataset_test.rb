require_relative "../test_helper"

module Tensorflow
  module Data
    class TensorSliceDatasetTest < Minitest::Test
      def test_array
        components = [[1], [2], [3]]
        dataset = TensorSliceDataset.new(components)
        assert_equal([[1, 2, 3]], dataset.data)
      end

      def test_narray
        components = [Numo::NArray[[1], [2], [3], [4]].tile(20),
                      Numo::NArray[[12], [13], [14], [15]].tile(22),
                      Numo::NArray[37.0, 38.0, 39.0, 40.0]]

        dataset = TensorSliceDataset.new(components)

        dataset.each_with_index do |slice, i|
          assert_equal(components[0].to_a[i], slice[0].value)
          assert_equal(components[1].to_a[i], slice[1].value)
          assert_equal(components[2].to_a[i], slice[2].value)

          assert_equal(components[0].shape[1..], slice[0].shape)
          assert_equal(components[1].shape[1..], slice[1].shape)
          assert_equal(components[2].shape[1..], slice[2].shape)
        end

        assert_equal([[[1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1],
                       [12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12, 12],
                       37.0],
                      [[2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2],
                       [13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13, 13],
                       38.0],
                      [[3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3],
                       [14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14],
                       39.0],
                      [[4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4],
                       [15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15],
                       40.0]], dataset.data)
      end
    end
  end
end
