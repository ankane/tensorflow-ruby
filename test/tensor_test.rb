require_relative "test_helper"

class TensorTest < Minitest::Test
  def test_narray_1_d
    narray = Numo::NArray[1, 2, 3, 4]
    tensor = Tensorflow::Tensor.new(narray)
    assert_equal([4], tensor.shape)
    assert_equal(:int32, tensor.dtype)
    assert_equal([1, 2, 3, 4], tensor.value)
  end

  def test_narray_2_d
    narray = Numo::NArray[[1], [2], [3], [4]]
    tensor = Tensorflow::Tensor.new(narray)
    pp tensor
    assert_equal([4, 1], tensor.shape)
    assert_equal(:int32, tensor.dtype)
    assert_equal([[1], [2], [3], [4]], tensor.value)
  end
end