require_relative "test_helper"

class ImageTest < Minitest::Test
  def test_decode_jpeg
    contents = Tf::IO.read_file("test/support/bears.jpg")
    assert_equal [227, 320, 3], Tf::Image.decode_jpeg(contents).shape
  end
end
