module TensorFlow
  module Test
    def self.compute_gradient(f, x, delta: 1e-3)
      xs = x.map { |xi| Tf.convert_to_tensor(xi) }
      p xs
      y = f.call(*xs)
      p y
      nil
    end
  end
end
