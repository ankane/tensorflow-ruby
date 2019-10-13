require_relative "../test_helper"

module Tensorflow
  module Data
    class MapDatasetTest < Minitest::Test
      # def test_simple
      #   components = [Numo::Int32.new(7).seq,
      #                 Numo::NArray[[1, 2, 3]] * Numo::Int32.new(7).seq[true, :new],
      #                 Numo::DFloat[37] * Numo::Int32.new(7).seq]
      #
      #   dataset = TensorDataset.new(components)
      #
      #   lambda = ->(x, y, z) do
      #     [x.square, y.square, z.square]
      #   end
      #
      #   map_dataset = MapDataset.new(dataset, lambda)
      #
      #   dataset.each_with_index do |slice, i|
      #     assert_equal(components[0].to_a[i], slice[0].value)
      #     assert_equal(components[1].to_a[i], slice[1].value)
      #     assert_equal(components[2].to_a[i], slice[2].value)
      #   end
      # end
    end
  end
end
