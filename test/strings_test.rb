require_relative "test_helper"

class StringsTest < Minitest::Test
  def test_join
    assert_equal "helloworld", Tf::Strings.join(["hello", "world"]).value
    assert_equal "hello world", Tf::Strings.join(["hello", "world"], separator: " ").value
  end

  def test_length
    assert_equal 5, Tf::Strings.length("hello").value
  end

  def test_lower
    assert_equal "hello", Tf::Strings.lower("HELLO").value
  end

  def test_to_number
    assert_equal 123, Tf::Strings.to_number("123").value
  end

  def test_strip
    assert_equal "hello", Tf::Strings.strip(" hello ").value
  end

  def test_upper
    assert_equal "HELLO", Tf::Strings.upper("hello").value
  end
end
