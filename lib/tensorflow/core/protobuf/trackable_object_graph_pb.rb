# Generated by the protocol buffer compiler.  DO NOT EDIT!
# source: tensorflow/core/protobuf/trackable_object_graph.proto

require 'google/protobuf'

Google::Protobuf::DescriptorPool.generated_pool.build do
  add_file("tensorflow/core/protobuf/trackable_object_graph.proto", :syntax => :proto3) do
    add_message "tensorflow.TrackableObjectGraph" do
      repeated :nodes, :message, 1, "tensorflow.TrackableObjectGraph.TrackableObject"
    end
    add_message "tensorflow.TrackableObjectGraph.TrackableObject" do
      repeated :children, :message, 1, "tensorflow.TrackableObjectGraph.TrackableObject.ObjectReference"
      repeated :attributes, :message, 2, "tensorflow.TrackableObjectGraph.TrackableObject.SerializedTensor"
      repeated :slot_variables, :message, 3, "tensorflow.TrackableObjectGraph.TrackableObject.SlotVariableReference"
    end
    add_message "tensorflow.TrackableObjectGraph.TrackableObject.ObjectReference" do
      optional :node_id, :int32, 1
      optional :local_name, :string, 2
    end
    add_message "tensorflow.TrackableObjectGraph.TrackableObject.SerializedTensor" do
      optional :name, :string, 1
      optional :full_name, :string, 2
      optional :checkpoint_key, :string, 3
      optional :optional_restore, :bool, 4
    end
    add_message "tensorflow.TrackableObjectGraph.TrackableObject.SlotVariableReference" do
      optional :original_variable_node_id, :int32, 1
      optional :slot_name, :string, 2
      optional :slot_variable_node_id, :int32, 3
    end
  end
end

module Tensorflow
  TrackableObjectGraph = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("tensorflow.TrackableObjectGraph").msgclass
  TrackableObjectGraph::TrackableObject = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("tensorflow.TrackableObjectGraph.TrackableObject").msgclass
  TrackableObjectGraph::TrackableObject::ObjectReference = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("tensorflow.TrackableObjectGraph.TrackableObject.ObjectReference").msgclass
  TrackableObjectGraph::TrackableObject::SerializedTensor = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("tensorflow.TrackableObjectGraph.TrackableObject.SerializedTensor").msgclass
  TrackableObjectGraph::TrackableObject::SlotVariableReference = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("tensorflow.TrackableObjectGraph.TrackableObject.SlotVariableReference").msgclass
end
