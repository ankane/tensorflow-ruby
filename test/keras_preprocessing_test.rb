require_relative "test_helper"

class KerasPreprocessingTest < Minitest::Test
  def test_image
    file = Tf::Keras::Utils.get_file("grace_hopper.jpg",
      "https://storage.googleapis.com/download.tensorflow.org/example_images/grace_hopper.jpg")
    img = Tf::Keras::Preprocessing::Image.load_img(file, target_size: [224, 224])
    x = Tf::Keras::Preprocessing::Image.img_to_array(img)
    assert_equal [224, 224, 3], x.shape
  end
end
