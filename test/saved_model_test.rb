require_relative "test_helper"

class SavedModelTest < Minitest::Test
  def test_load
    # labels_path = Tf::Keras::Utils.get_file("ImageNetLabels.txt",
    #   "https://storage.googleapis.com/download.tensorflow.org/data/ImageNetLabels.txt")
    # imagenet_labels = File.readlines(labels_path).map(&:chomp)
    # p imagenet_labels

    Tf::SavedModel.load("/tmp/mobilenet/1")
  end
end
