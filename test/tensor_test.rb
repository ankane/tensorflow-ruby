require_relative "test_helper"

module Tensorflow
  class TensorTest < Minitest::Test
    def test_narray_1_d
      narray = Numo::NArray[1, 2, 3, 4]
      tensor = Tensor.new(narray)
      assert_equal([4], tensor.shape)
      assert_equal(:int32, tensor.dtype)
      assert_equal([1, 2, 3, 4], tensor.value)
    end

    def test_narray_2_d
      narray = Numo::NArray[[1], [2], [3], [4]]
      tensor = Tensor.new(narray)
      assert_equal([4, 1], tensor.shape)
      assert_equal(:int32, tensor.dtype)
      assert_equal([[1], [2], [3], [4]], tensor.value)
    end

    def test_string
      value = "I am a string"
      tensor = Tensor.new(value)
      puts tensor
      assert_equal([], tensor.shape)
      assert_equal(:string, tensor.dtype)
      assert_equal(value, tensor.value)
    end

    def test_integer
      value = 9
      tensor = Tensor.new(value)
      assert_equal([], tensor.shape)
      assert_equal(:int32, tensor.dtype)
      assert_equal(value, tensor.value)
    end

    def test_const_integer
      value = 9
      tensor = Tensor.constant(value)
      assert_equal([], tensor.shape)
      assert_equal(:int32, tensor.dtype)
      assert_equal(value, tensor.value)
    end
  end
end 
