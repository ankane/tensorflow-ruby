module TensorFlow
  class GradientTape
    def initialize
      yield
    end

    def gradient(target, sources)
      puts "imperative_grad"
      p target
      p sources
    end
  end
end
