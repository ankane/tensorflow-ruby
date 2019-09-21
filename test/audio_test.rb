require_relative "test_helper"

class AudioTest < Minitest::Test
  def test_decode_wav
    assert_raises(TensorFlow::Error) do
      Tf::Audio.decode_wav("hi")
    end
  end
end
