require_relative "test_helper"

class ZipDatasetTest < Minitest::Test
  def test_equal_length_components
    components = [Numo::NArray[[1], [2], [3], [4]].tile(20),
                  Numo::NArray[[12], [13], [14], [15]].tile(22),
                  Numo::NArray[37.0, 38.0, 39.0, 40.0]]

    datasets = components.map do |component|
      Tensorflow::Data::TensorSliceDataset.new(components)
    end

    dataset = Tensorflow::Data::ZipDataset.new(datasets)
    puts dataset
  end
end
