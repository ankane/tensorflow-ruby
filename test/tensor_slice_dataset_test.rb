require_relative "test_helper"

class TensorSliceDatasetTest < Minitest::Test
  def test_from_tensor_slices
    components = [Numo::NArray[[1], [2], [3], [4]].tile(20),
                  Numo::NArray[[12], [13], [14], [15]].tile(22),
                  Numo::NArray[37.0, 38.0, 39.0, 40.0]]

    dataset = Tensorflow::Data::TensorSliceDataset.new(components)

    dataset.each_with_index do |slice, i|
      assert_equal(components[0].to_a[i], slice[0].value)
      assert_equal(components[1].to_a[i], slice[1].value)
      assert_equal(components[2].to_a[i], slice[2].value)
    end
  end
end
