# https://github.com/tensorflow/tensorflow/blob/master/tensorflow/python/eager/backprop.py
module TensorFlow
  class GradientTape
    def initialize(persistent: false, watch_accessed_variables: true)
      @tape = nil
      @persistent = persistent
      @watch_accessed_variables = watch_accessed_variables
      @watched_variables = []
      @recording = false
    end

    def with
      push_tape
      yield
    ensure
      pop_tape if @recording
    end

    def watch(tensor)
      Tape.watch(@tape, tensor)
    end

    def gradient(target, sources)
      Tape.gradient(@tape, target, sources)
    end

    private

    def push_tape
      if @recording
        raise Error, "Tape is still recording, This can happen if you try to re-enter an already-active tape."
      end
      if @tape.nil?
        @tape = Tape.push_new_tape(@persistent, @watch_accessed_variables)
      else
        raise NotImplementedYet
      end
      @recording = true
    end

    def pop_tape
      unless @recording
        raise Error, "Tape is not recording."
      end
      Tape.pop_tape(@tape)
      @recording = false
    end
  end
end
