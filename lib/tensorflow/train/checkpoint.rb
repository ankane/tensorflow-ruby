module TensorFlow
  module Train
    class Checkpoint
      def initialize(vars)
        @vars = vars
      end

      def save(file_prefix)
        checkpoint_number = 1

        file_path = "%s-%d" % [file_prefix, checkpoint_number]

        p file_path

        file_path
      end

      def restore(save_path)

      end
    end
  end
end
