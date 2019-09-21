require_relative "test_helper"

class IOTest < Minitest::Test
  def test_decode_base64
    message = "hello"
    encoded = Base64.strict_encode64(message)
    assert_equal message, Tf::IO.decode_base64(encoded).value
  end

  def test_read_file
    now = Time.now.to_i.to_s
    File.binwrite(tempfile, now)
    assert_equal now, Tf::IO.read_file(tempfile).value
  end

  def test_write_file
    now = Time.now.to_i.to_s
    Tf::IO.write_file(tempfile, now)
    assert_equal now, File.binread(tempfile)
  end
end
