require_relative "test_helper"

class OperationsTest < Minitest::Test
  def test_abs
    assert_equal 1, Tf.abs(Tf.constant(-1)).value
  end

  def test_add
    a = Tf.constant(2)
    b = Tf.constant(3)
    assert_equal 5, (a + b).value

    a = Tf.constant([[1, 2], [3, 4]])
    b = Tf.add(a, 1)
    assert_equal [[2, 6], [12, 20]], (a * b).value
  end

  def test_divide
    a = Tf.constant(2)
    b = Tf.constant(3)
    assert_in_delta 0, (a / b).value
    assert_in_delta 0, Tf.divide(a, b).value
  end

  def test_equal
    x = Tf.constant([2, 4])
    y = Tf.constant(2)
    assert_equal [true, false], Tf.equal(x, y).value

    x = Tf.constant([2, 4])
    y = Tf.constant([2, 4])
    assert_equal [true, true], Tf.equal(x, y).value
  end

  def test_fill
    assert_equal [[9, 9, 9], [9, 9, 9]], Tf.fill([2, 3], 9).value
  end

  def test_identity
    [:float, :double, :int32, :uint8, :int16, :int8, :int64, :uint16, :uint32, :uint64, :bool, :string].each do |dtype|
      value =
        case dtype
        when :string
          "hello"
        when :bool
          true
        else
          0
        end

      tensor = Tf.identity(Tf.constant(value, dtype: dtype))
      assert_equal value, tensor.value
      assert_equal dtype, tensor.dtype
    end
  end

  def test_matmul
    x = [[2.0]]
    assert_equal [[4.0]], Tf.matmul(x, x).value
  end

  def test_multiply
    a = Tf.constant(2)
    b = Tf.constant(3)
    assert_equal 6, (a * b).value
    assert_equal 6, Tf.multiply(a, b).value
  end

  def test_ones
    assert_equal [[1, 1, 1], [1, 1, 1]], Tf.ones([2, 3]).value
  end

  def test_range
    assert_equal [3, 6, 9, 12, 15], Tf.range(3, 18, 3).value
  end

  def test_sin
    assert_equal [0, 1], Tf.sin([0.0, 0.5 * Math::PI]).value
  end

  def test_sqrt
    assert_equal 3.0, Tf.sqrt(Tf.constant(9.0)).value
  end

  def test_subtract
    a = Tf.constant(2)
    b = Tf.constant(3)
    assert_equal -1, (a - b).value
    assert_equal -1, Tf.subtract(a, b).value
  end

  def test_timestamp
    assert_in_delta Time.now.to_f, Tf.timestamp.value, 1
  end

  def test_transpose
    assert_equal [[1, 4], [2, 5], [3, 6]], Tf.transpose([[1, 2, 3], [4, 5, 6]]).value
  end

  def test_zeros
    assert_equal [[0, 0, 0], [0, 0, 0]], Tf.zeros([2, 3]).value
  end

  def test_zeros_like
    assert_equal [[0, 0, 0], [0, 0, 0]], Tf.zeros_like(Tf.ones([2, 3])).value
  end
end
