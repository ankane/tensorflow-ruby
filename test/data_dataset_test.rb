require_relative "test_helper"

class DataDatasetTest < Minitest::Test
  def test_from_tensor_slices
    mnist = Tf::Keras::Datasets::MNIST
    (x_train, y_train), (x_test, y_test) = mnist.load_data

    image_shapes = []
    label_shapes = []

    train_ds = Tf::Data::Dataset.from_tensor_slices([x_train, y_train]).shuffle(10000).batch(32)
    train_ds.each_with_index do |(images, labels), i|
      image_shapes << images.shape
      label_shapes << labels.shape
      assert_equal [32, 28, 28], images.shape
      assert_equal [32], labels.shape
    end

    assert_equal [[32, 28, 28]] * 1875, image_shapes
    assert_equal [[32]] * 1875, label_shapes
  end
end
