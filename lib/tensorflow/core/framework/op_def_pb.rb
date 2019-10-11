# Generated by the protocol buffer compiler.  DO NOT EDIT!
# source: tensorflow/core/framework/op_def.proto

require 'google/protobuf'

require 'tensorflow/core/framework/attr_value_pb'
require 'tensorflow/core/framework/types_pb'
Google::Protobuf::DescriptorPool.generated_pool.build do
  add_file("tensorflow/core/framework/op_def.proto", :syntax => :proto3) do
    add_message "tensorflow.OpDef" do
      optional :name, :string, 1
      repeated :input_arg, :message, 2, "tensorflow.OpDef.ArgDef"
      repeated :output_arg, :message, 3, "tensorflow.OpDef.ArgDef"
      repeated :control_output, :string, 20
      repeated :attr, :message, 4, "tensorflow.OpDef.AttrDef"
      optional :deprecation, :message, 8, "tensorflow.OpDeprecation"
      optional :summary, :string, 5
      optional :description, :string, 6
      optional :is_commutative, :bool, 18
      optional :is_aggregate, :bool, 16
      optional :is_stateful, :bool, 17
      optional :allows_uninitialized_input, :bool, 19
    end
    add_message "tensorflow.OpDef.ArgDef" do
      optional :name, :string, 1
      optional :description, :string, 2
      optional :type, :enum, 3, "tensorflow.DataType"
      optional :type_attr, :string, 4
      optional :number_attr, :string, 5
      optional :type_list_attr, :string, 6
      optional :is_ref, :bool, 16
    end
    add_message "tensorflow.OpDef.AttrDef" do
      optional :name, :string, 1
      optional :type, :string, 2
      optional :default_value, :message, 3, "tensorflow.AttrValue"
      optional :description, :string, 4
      optional :has_minimum, :bool, 5
      optional :minimum, :int64, 6
      optional :allowed_values, :message, 7, "tensorflow.AttrValue"
    end
    add_message "tensorflow.OpDeprecation" do
      optional :version, :int32, 1
      optional :explanation, :string, 2
    end
    add_message "tensorflow.OpList" do
      repeated :op, :message, 1, "tensorflow.OpDef"
    end
  end
end

module Tensorflow
  OpDef = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("tensorflow.OpDef").msgclass
  OpDef::ArgDef = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("tensorflow.OpDef.ArgDef").msgclass
  OpDef::AttrDef = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("tensorflow.OpDef.AttrDef").msgclass
  OpDeprecation = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("tensorflow.OpDeprecation").msgclass
  OpList = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("tensorflow.OpList").msgclass
end
