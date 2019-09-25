require_relative "test_helper"

class GradientTapeTest < Minitest::Test
  def test_works
    x = Tf.constant(3.0)
    y = nil

    g = Tf::GradientTape.new do |g2|
      g2.watch(x)
      y = x * x
    end
    dy_dx = g.gradient(y, x)
    p dy_dx
  end
end
