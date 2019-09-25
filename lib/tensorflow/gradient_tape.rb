module TensorFlow
  class GradientTape
    def initialize
      context = Utils.default_context
      context.start_step

      yield(self) if block_given?
    end

    def watch(tensor)
      puts "watch"
    end

    def gradient(target, sources)
      puts "imperative_grad"
      # p target
      # p sources
      # p sources.map(&:shape)
    end
  end
end
