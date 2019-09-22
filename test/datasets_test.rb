require_relative "test_helper"

class DatasetsTest < Minitest::Test
  def test_boston_housing
    boston_housing = Tf::Keras::Datasets::BostonHousing
    (x_train, y_train), (x_test, y_test) = boston_housing.load_data

    assert_equal [404, 13], x_train.shape
    assert_equal [404], y_train.shape
    assert_equal [102, 13], x_test.shape
    assert_equal [102], y_test.shape
  end

  def test_mnist
    mnist = Tf::Keras::Datasets::MNIST
    (x_train, y_train), (x_test, y_test) = mnist.load_data

    assert_equal [60000, 28, 28], x_train.shape
    assert_equal [60000], y_train.shape
    assert_equal [10000, 28, 28], x_test.shape
    assert_equal [10000], y_test.shape
  end
end
