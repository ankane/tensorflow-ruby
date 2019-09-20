require_relative "test_helper"

class OperationsTest < Minitest::Test
  def test_fill
    assert_equal [[9, 9, 9], [9, 9, 9]], Tf.fill([2, 3], 9).value
    assert_equal [[0, 0, 0], [0, 0, 0]], Tf.zeros([2, 3]).value
    assert_equal [[1, 1, 1], [1, 1, 1]], Tf.ones([2, 3]).value
    assert_equal [[0, 0, 0], [0, 0, 0]], Tf.zeros_like(Tf.ones([2, 3])).value
  end

  def test_range
    assert_equal [3, 6, 9, 12, 15], Tf.range(3, 18, 3).value
  end

  def test_sin
    assert_equal [0, 1], Tf.sin([0.0, 0.5 * Math::PI]).value
  end

  def test_transpose
    assert_equal [[1, 4], [2, 5], [3, 6]], Tf.transpose([[1, 2, 3], [4, 5, 6]]).value
  end

  def test_timestamp
    assert_in_delta Time.now.to_f, Tf.timestamp.value, 1
  end

  def test_equal
    x = Tf.constant([2, 4])
    y = Tf.constant(2)
    assert_equal [true, false], Tf.equal(x, y).value

    x = Tf.constant([2, 4])
    y = Tf.constant([2, 4])
    assert_equal [true, true], Tf.equal(x, y).value
  end
end
