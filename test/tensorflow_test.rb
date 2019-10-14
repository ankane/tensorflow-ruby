require_relative "test_helper"

class TensorFlowTest < Minitest::Test
  def test_version
    assert TensorFlow.library_version
  end

  def test_hello
    hello = Tf.constant("Hello, TensorFlow!")
    assert_equal "Hello, TensorFlow!", hello.value
  end

  def test_constant
    a = Tf.constant([1, 2, 3, 4, 5, 6], shape: [2, 3])
    assert_equal [[1, 2, 3], [4, 5, 6]], a.value
  end

  def test_infer_type
    assert_equal :float, Tf.constant(1.0).dtype
    assert_equal :float, Tf.constant(1.234567890123456789).dtype
    assert_equal :bool, Tf.constant([true, false]).dtype
    assert_equal :int32, Tf.constant(1).dtype
    assert_equal :int32, Tf.constant(2147483647).dtype
    assert_equal :int32, Tf.constant(-2147483648).dtype
    assert_equal :int64, Tf.constant(2147483648).dtype
    assert_equal :int64, Tf.constant(-2147483649).dtype
    assert_equal :complex128, Tf.constant(Complex(2, 3)).dtype
    assert_equal :string, Tf.constant(["hello", "world"]).dtype
    error = assert_raises(TensorFlow::Error) do
      Tf.constant(["hello", 1])
    end
    assert_equal "Unable to infer data type", error.message
  end

  def test_variable
    v = Tf::Variable.new(0.0)
    w = v + 1
    assert_equal 0.0, v.read_value.value
    assert_equal 1.0, w.value

    x = v - 1
    assert_equal 0.0, v.read_value.value
    assert_equal -1.0, x.value
  end

  def test_fizzbuzz
    ret = []
    15.times do |i|
      num = Tf.constant(i + 1)
      if (num % 3).to_i == 0 && (num % 5).to_i == 0
        ret << "FizzBuzz"
      elsif (num % 3).to_i == 0
        ret << "Fizz"
      elsif (num % 5).to_i == 0
        ret << "Buzz"
      else
        ret << num.to_i
      end
    end
    assert_equal [1, 2, "Fizz", 4, "Buzz", "Fizz", 7, 8, "Fizz", "Buzz", 11, "Fizz", 13, 14, "FizzBuzz"], ret
  end

  def test_numo
    TensorFlow::Utils::NUMO_TYPE_MAP.each do |type, klass|
      value =
        case type
        when :float, :double
          [2.5, 3.5]
        else
          [1, 2]
        end

      a = klass.cast(value)
      assert_equal a, Tf.identity(a).numo
    end
  end
end
