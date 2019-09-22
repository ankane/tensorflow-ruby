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

  # def test_fashion_mnist
  #   fashion_mnist = Tf::Keras::Datasets::FashionMNIST
  #   (x_train, y_train), (x_test, y_test) = mnist.load_data

  #   assert_equal [60000, 28, 28], x_train.shape
  #   assert_equal [60000], y_train.shape
  #   assert_equal [10000, 28, 28], x_test.shape
  #   assert_equal [10000], y_test.shape
  # end

  def test_imdb
    imdb = Tf::Keras::Datasets::IMDB
    # (x_train, y_train), (x_test, y_test) = imdb.load_data

    # assert_equal [25000], x_train.shape
    # assert_equal [25000], y_train.shape
    # assert_equal [25000], x_test.shape
    # assert_equal [25000], y_test.shape

    assert_equal 88584, imdb.get_word_index.size
  end

  def test_mnist
    mnist = Tf::Keras::Datasets::MNIST
    (x_train, y_train), (x_test, y_test) = mnist.load_data

    assert_equal [60000, 28, 28], x_train.shape
    assert_equal [60000], y_train.shape
    assert_equal [10000, 28, 28], x_test.shape
    assert_equal [10000], y_test.shape
  end

  def test_reuters
    reuters = Tf::Keras::Datasets::Reuters
    # (x_train, y_train), (x_test, y_test) = reuters.load_data

    # assert_equal [8982], x_train.shape
    # assert_equal [8982], y_train.shape
    # assert_equal [2246], x_test.shape
    # assert_equal [2246], y_test.shape

    assert_equal 30979, reuters.get_word_index.size
  end
end
