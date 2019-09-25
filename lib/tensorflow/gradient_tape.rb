module TensorFlow
  class GradientTape
    def initialize
      context = Utils.default_context
      FFI.TFE_ContextStartStep(context)

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
