require_relative "test_helper"

class StringsTest < Minitest::Test
  def test_lower
    assert_equal "hello", Tf::Strings.lower("HELLO").value
  end
end
