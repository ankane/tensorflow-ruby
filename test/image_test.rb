require_relative "test_helper"

class ImageTest < Minitest::Test
  def test_decode_jpeg
    assert_equal [227, 320, 3], Tf::Image.decode_jpeg(jpeg_contents).shape
  end

  def test_is_jpeg
    assert Tf::Image.is_jpeg(jpeg_contents).value
    assert Tf::IO.is_jpeg(jpeg_contents).value
    assert !Tf::Image.is_jpeg("notjpeg").value
    assert !Tf::IO.is_jpeg("notjpeg").value
  end

  def test_resize
    image = Tf::Image.decode_jpeg(jpeg_contents)
    assert_equal [192, 192, 3], Tf::Image.resize(image, [192, 192]).shape
  end

  private

  def jpeg_contents
    Tf::IO.read_file("test/support/bears.jpg")
  end
end
