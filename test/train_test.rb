require_relative "test_helper"

class TrainTest < Minitest::Test
  def test_checkpoint
    x = Tf::Variable.new(10.0)
    checkpoint = Tf::Train::Checkpoint.new(x: x)

    x.assign(2.0)

    checkpoint.save(tempfile)

    x.assign(11.0)

    checkpoint.restore(Tf::Train.latest_checkpoint(tempfile))

    p x
  end
end
