module TensorFlow
  module SavedModel
    class << self
      def load(export_dir)
        path = "#{ENV["HOME"]}/forks/tensorflow"
        $:.push(path)
        require "tensorflow/core/protobuf/saved_model_pb"

        pb_file = File.join(export_dir, "saved_model.pb")
        saved_model_proto = Tensorflow::SavedModel.decode(File.read(pb_file))
        meta_graph_def = saved_model_proto.meta_graphs[0]
        object_graph_proto = meta_graph_def.object_graph_def
        # p object_graph_proto.class.name
        # p meta_graph_def.meta_info_def.tensorflow_version
        # p meta_graph_def.meta_info_def.tensorflow_git_version
        concrete_functions = load_function_def_library(meta_graph_def.graph_def.library)
      end

      private

      def load_function_def_library(library)
        functions = {}

        library.function.each do |fdef|
          p fdef.signature.name

          functions[fdef.signature.name] = nil
        end

        p functions

        functions
      end
    end
  end
end
