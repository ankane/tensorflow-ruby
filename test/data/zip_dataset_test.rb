require_relative "../test_helper"

module Tensorflow
  module Data
    class ZipDatasetTest < Minitest::Test
      def test_equal_length_components
        components = [Numo::NArray[[1], [2], [3], [4]].tile(20),
                      Numo::NArray[[12], [13], [14], [15]].tile(22),
                      Numo::NArray[37.0, 38.0, 39.0, 40.0]]

        datasets = components.map do |component|
          TensorSliceDataset.new(component)
        end

        dataset = Data::ZipDataset.new(datasets)

        dataset.each_with_index do |slice, i|
          assert_equal(components[0].to_a[i], slice[0].value)
          assert_equal(components[1].to_a[i], slice[1].value)
          assert_equal(components[2].to_a[i], slice[2].value)
        end
      end


      def test_variable_length_components
        skip
        components = [[1, 2, 3, 4],
                      [1, 2, 3, 4, 5],
                      [1.0, 2.0]]

        datasets = components.map do |component|
          TensorSliceDataset.new(component)
        end

        dataset = Data::ZipDataset.new(datasets)

        dataset.each_with_index do |slice, i|
          assert_equal(components[0].to_a[i], slice[0].value)
          assert_equal(components[1].to_a[i], slice[1].value)
          assert_equal(components[2].to_a[i], slice[2].value)
        end
      end
    end
  end
end
