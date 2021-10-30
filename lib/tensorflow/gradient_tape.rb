# https://github.com/tensorflow/tensorflow/blob/master/tensorflow/python/eager/backprop.py
module TensorFlow
  class GradientTape
    def initialize(persistent: false)
      @persistent = persistent
      @recording = false
    end

    def with
      push_tape
    ensure
      pop_tape if @recording
    end

    def watch(tensor)
      # TODO tape.watch
    end

    def gradient(target, sources)
      # TODO
    end

    private

    def push_tape
      if @recording
        raise Error, "Tape is still recording, This can happen if you try to re-enter an already-active tape."
      end
      # TODO tape.push
      @recording = true
    end

    def pop_tape
      unless @recording
        raise Error, "Tape is not recording."
      end
      # TODO tape.pop
      @recording = false
    end
  end
end
