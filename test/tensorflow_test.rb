require_relative "test_helper"

class TensorFlowTest < Minitest::Test
  def test_version
    assert_equal "1.14.0", TensorFlow.library_version
  end

  def test_hello
    hello = Tf.constant("Hello, TensorFlow!")
    assert_equal "Hello, TensorFlow!", hello.value
  end

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

  def test_works
    a = Tf.constant(2)
    b = Tf.constant(3)

    assert_equal 5, (a + b).value
    assert_equal -1, (a - b).value
    assert_equal 6, (a * b).value
    assert_in_delta 0, (a / b).value

    assert_equal 1, Tf.abs(Tf.constant(-1)).value
    assert_equal 3.0, Tf.sqrt(Tf.constant(9.0)).value
    x = [[2.0]]
    assert_equal [[4.0]], Tf.matmul(x, x).value

    a = Tf.constant([[1, 2], [3, 4]])
    b = Tf.add(a, 1)
    assert_equal [[2, 6], [12, 20]], (a * b).value
  end

  def test_constant
    a = Tf.constant([1, 2, 3, 4, 5, 6], shape: [2, 3])
    assert_equal [[1, 2, 3], [4, 5, 6]], a.value
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

  def test_keras
    mnist = Tf::Keras::Datasets::MNIST
    (x_train, y_train), (x_test, y_test) = mnist.load_data
    x_train = x_train / 255.0
    x_test = x_test / 255.0

    model = Tf::Keras::Models::Sequential.new([
      Tf::Keras::Layers::Flatten.new(input_shape: [28, 28]),
      Tf::Keras::Layers::Dense.new(128, activation: "relu"),
      Tf::Keras::Layers::Dropout.new(0.2),
      Tf::Keras::Layers::Dense.new(10, activation: "softmax")
    ])

    skip

    model.compile(optimizer: "adam", loss: "sparse_categorical_crossentropy", metrics: ["accuracy"])
    model.fit(x_train, y_train, epochs: 5)
    model.evaluate(x_test, y_test)
  end
end
