require_relative "test_helper"

class SavedModelTest < Minitest::Test
  def test_load
    file = Tf::Keras::Utils.get_file("grace_hopper.jpg",
      "https://storage.googleapis.com/download.tensorflow.org/example_images/grace_hopper.jpg")
    img = Tf::Keras::Preprocessing::Image.load_img(file, target_size: [224, 224])
    p img
    x = Tf::Keras::Preprocessing::Image.img_to_array(img)
    p x

    # labels_path = Tf::Keras::Utils.get_file("ImageNetLabels.txt",
    #   "https://storage.googleapis.com/download.tensorflow.org/data/ImageNetLabels.txt")
    # imagenet_labels = File.readlines(labels_path).map(&:chomp)
    # p imagenet_labels

    Tf::SavedModel.load("/tmp/mobilenet/1")
  end
end
