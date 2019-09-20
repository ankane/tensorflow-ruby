require_relative "test_helper"

class TensorFlowTest < Minitest::Test
  def test_version
    assert_equal "1.14.0", TensorFlow.library_version
  end

  def test_hello
    hello = Tf.constant("Hello, TensorFlow!")
    assert_equal "Hello, TensorFlow!", hello.value
  end

  def test_works
    a = Tf.constant(2)
    b = Tf.constant(3)

    assert_equal 5, (a + b).value
    assert_equal -1, (a - b).value
    assert_equal 6, (a * b).value
    assert_in_delta 0, (a / b).value

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
