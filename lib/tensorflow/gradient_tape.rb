module TensorFlow
  class GradientTape
    def initialize
      context = Utils.default_context
      context.start_step

      yield(self) if block_given?
    end

    def watch(tensor)
    end

    def gradient(target, sources)
    end
  end
end
