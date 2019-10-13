require_relative "test_helper"

class BitwiseTest < Minitest::Test
  def test_bitwise_and
    lhs = Tf::Tensor.constant([0, 5, 3, 14])
    rhs = Tf::Tensor.constant([5, 0, 7, 11])
    assert_equal [0, 0, 3, 10], Tf::Bitwise.bitwise_and(lhs, rhs).value
  end
end
