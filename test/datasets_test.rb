require_relative "test_helper"

class DatasetsTest < Minitest::Test
  def test_mnist
    mnist = Tf::Keras::Datasets::MNIST
    (x_train, y_train), (x_test, y_test) = mnist.load_data

    assert_equal [60000, 28, 28], x_train.shape
    assert_equal [60000], y_train.shape
    assert_equal [10000, 28, 28], x_test.shape
    assert_equal [10000], y_test.shape
  end
end
