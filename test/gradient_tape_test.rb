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

  def test_compute_gradient
    test_func = ->(x) { x * x }
    p Tf::Test.compute_gradient(test_func, [3.0])
  end
end
