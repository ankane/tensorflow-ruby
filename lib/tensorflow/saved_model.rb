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
        library_function_names = Set.new(library.function.map { |fdef| fdef.signature.name })
        functions = {}

        sort_function_defs(library, library_function_names).each do |fdef|
          functions[fdef.signature.name] = nil
        end

        functions.keys.each do |key|
          puts key
        end

        functions
      end

      def sort_function_defs(library, library_function_names)
        edges = Hash.new { |hash, key| hash[key] = [] }
        in_count = Hash.new(0)

        library.function.each do |fdef|
          list_function_deps(fdef, library_function_names).each do |dep|
            edges[dep] << fdef.signature.name
            in_count[fdef.signature.name] += 1
          end
        end

        ready = library.function.map { |fdef| fdef.signature.name }.select { |name| in_count[name] == 0 }
        output = []

        while ready.any?
          node = ready.pop
          output << node

          edges[node].each do |dest|
            in_count[dest] -= 1
            if in_count[dest] == 0
              ready << dest
            end
          end
        end

        if output.size != library.function.size
          failed_to_resolve = (in_count.keys - output).sort
          raise Error, "There is a cyclic-dependency between functions. Could not resolve #{failed_to_resolve.join(", ")}."
        end

        reverse = library.function.map { |fdef| [fdef.signature.name, fdef] }.to_h
        output.map { |x| reverse[x] }
      end

      def list_function_deps(fdef, library_function_names)
        deps = Set.new

        fdef.node_def.each do |node_def|
          if library_function_names.include?(node_def.op)
            deps << node_def.op
          else
            node_def.attr.each do |_, attr_value|
              if attr_value.func
                deps << attr_value.func.name
              end
            end
          end
        end
        deps
      end
    end
  end
end
