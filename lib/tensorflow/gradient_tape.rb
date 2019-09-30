module TensorFlow
  class GradientTape
    def initialize
      context = Utils.default_context
      context.start_step

      @tensor_tape = {}
      @tensor_usage = {}

      yield(self) if block_given?
    end

    def watch(tensor)
      i = 1 # tensor_id
      unless @tensor_tape[i]
        @tensor_tape[i] ||= tensor
        @tensor_usage[i] = 1
      end
    end

    def gradient(target, sources)
      p target
      p sources
      "hi"
    end
  end
end
