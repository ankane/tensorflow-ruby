module TensorFlow
  class GradientTape
    def initialize
      context = Utils.default_context
      context.start_step

      yield
    end

    def gradient(target, sources)
      puts "imperative_grad"
      p target
      # p sources
      p sources.map(&:shape)
    end
  end
end
