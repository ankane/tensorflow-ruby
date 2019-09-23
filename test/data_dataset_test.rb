require_relative "test_helper"

class DataDatasetTest < Minitest::Test
  def test_from_tensor_slices
    mnist = Tf::Keras::Datasets::MNIST
    (x_train, y_train), (x_test, y_test) = mnist.load_data

    train_ds = Tf::Data::Dataset.from_tensor_slices([x_train, y_train]).shuffle(10000).batch(32)
    i = 0
    train_ds.each do |images, labels|
      assert_equal [32, 28, 28], images.shape
      assert_equal [32], labels.shape
      i += 1
    end
    assert_equal 1875, i
  end
end
