require_relative "../test_helper"

class KerasOptimizersTest < Minitest::Test
  def test_adam
    opt = Tf::Keras::Optimizers::Adam.new(learning_rate: 0.1)
    var1 = Tf::Variable.new(10.0)
    loss = lambda { (var1 ** 2) / 2.0 }
    step_count = opt.minimize(loss, [var1]).numo
    assert_equal 1, step_count[0]
    assert_in_delta 9.9, var1.numo[0]
  end
end
