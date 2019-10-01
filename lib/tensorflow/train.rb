module TensorFlow
  module Train
    class << self
      def latest_checkpoint(checkpoint_dir)
        "#{checkpoint_dir}-1"
      end
    end
  end
end
