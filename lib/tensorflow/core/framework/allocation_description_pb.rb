# Generated by the protocol buffer compiler.  DO NOT EDIT!
# source: tensorflow/core/framework/allocation_description.proto

require 'google/protobuf'

Google::Protobuf::DescriptorPool.generated_pool.build do
  add_file("tensorflow/core/framework/allocation_description.proto", :syntax => :proto3) do
    add_message "tensorflow.AllocationDescription" do
      optional :requested_bytes, :int64, 1
      optional :allocated_bytes, :int64, 2
      optional :allocator_name, :string, 3
      optional :allocation_id, :int64, 4
      optional :has_single_reference, :bool, 5
      optional :ptr, :uint64, 6
    end
  end
end

module Tensorflow
  AllocationDescription = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("tensorflow.AllocationDescription").msgclass
end
