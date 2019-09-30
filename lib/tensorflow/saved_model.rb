module TensorFlow
  module SavedModel
    class << self
      def load(export_dir)
        path = "#{ENV["HOME"]}/forks/tensorflow"
        $:.push(path)
        require "tensorflow/core/protobuf/saved_model_pb"

        pb_file = File.join(export_dir, "saved_model.pb")
        Tensorflow::SavedModel.decode(File.read(pb_file))
      end
    end
  end
end
