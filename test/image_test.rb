require_relative "test_helper"

class ImageTest < Minitest::Test
  def test_decode_gif
    assert_raises(TensorFlow::Error) do
      Tf::Image.decode_gif("hi")
    end
  end
end
