require_relative "test_helper"

class LinalgTest < Minitest::Test
  def test_matmul
    x = [[2.0]]
    assert_equal [[4.0]], Tf.matmul(x, x).value
    assert_equal [[4.0]], Tf::Linalg.matmul(x, x).value
  end
end
