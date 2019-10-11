require_relative "test_helper"

class ContextTest < Minitest::Test
  def test_works
    context = Tensorflow::Utils.default_context
    assert !context.function?("hi")
    assert_equal :silent, context.device_policy
    context.enable_run_metadata
    context.disable_run_metadata
  end
end
