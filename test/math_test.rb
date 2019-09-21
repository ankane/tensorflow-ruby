require_relative "test_helper"

class MathTest < Minitest::Test
  def test_abs
    assert_equal 1, Tf.abs(Tf.constant(-1)).value
    assert_equal 1, Tf::Math.abs(Tf.constant(-1)).value
  end

  def test_add
    a = Tf.constant(2)
    b = Tf.constant(3)
    assert_equal 5, (a + b).value
    assert_equal 5, Tf.add(a, b).value
    assert_equal 5, Tf::Math.add(a, b).value
  end

  def test_divide
    a = Tf.constant(3.0)
    b = Tf.constant(2.0)
    assert_in_delta 1.5, (a / b).value
    assert_in_delta 1.5, Tf.divide(a, b).value
    assert_in_delta 1.5, Tf::Math.divide(a, b).value
  end

  def test_equal
    x = Tf.constant([2, 4])
    y = Tf.constant(2)
    assert_equal [true, false], Tf.equal(x, y).value
    assert_equal [true, false], Tf::Math.equal(x, y).value

    x = Tf.constant([2, 4])
    y = Tf.constant([2, 4])
    assert_equal [true, true], Tf.equal(x, y).value
    assert_equal [true, true], Tf::Math.equal(x, y).value
  end

  def test_multiply
    a = Tf.constant(2)
    b = Tf.constant(3)
    assert_equal 6, (a * b).value
    assert_equal 6, Tf.multiply(a, b).value
    assert_equal 6, Tf::Math.multiply(a, b).value

    a = Tf.constant([[1, 2], [3, 4]])
    b = Tf.add(a, 1)
    assert_equal [[2, 6], [12, 20]], (a * b).value
  end

  def test_sin
    assert_equal [0, 1], Tf.sin([0.0, 0.5 * Math::PI]).value
    assert_equal [0, 1], Tf::Math.sin([0.0, 0.5 * Math::PI]).value
  end

  def test_sqrt
    assert_equal [2.0, 3.0], Tf.sqrt([4.0, 9.0]).value
    assert_equal [2.0, 3.0], Tf::Math.sqrt([4.0, 9.0]).value
  end

  def test_subtract
    a = Tf.constant(2)
    b = Tf.constant(3)
    assert_equal -1, (a - b).value
    assert_equal -1, Tf.subtract(a, b).value
    assert_equal -1, Tf::Math.subtract(a, b).value
  end
end
