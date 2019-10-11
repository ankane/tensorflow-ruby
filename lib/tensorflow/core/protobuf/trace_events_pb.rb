# Generated by the protocol buffer compiler.  DO NOT EDIT!
# source: tensorflow/core/protobuf/trace_events.proto

require 'google/protobuf'

Google::Protobuf::DescriptorPool.generated_pool.build do
  add_file("tensorflow/core/protobuf/trace_events.proto", :syntax => :proto3) do
    add_message "tensorflow.profiler.Trace" do
      map :devices, :uint32, :message, 1, "tensorflow.profiler.Device"
      repeated :trace_events, :message, 4, "tensorflow.profiler.TraceEvent"
    end
    add_message "tensorflow.profiler.Device" do
      optional :name, :string, 1
      optional :device_id, :uint32, 2
      map :resources, :uint32, :message, 3, "tensorflow.profiler.Resource"
    end
    add_message "tensorflow.profiler.Resource" do
      optional :name, :string, 1
      optional :resource_id, :uint32, 2
    end
    add_message "tensorflow.profiler.TraceEvent" do
      optional :device_id, :uint32, 1
      optional :resource_id, :uint32, 2
      optional :name, :string, 3
      optional :timestamp_ps, :uint64, 9
      optional :duration_ps, :uint64, 10
      map :args, :string, :string, 11
    end
  end
end

module Tensorflow
  module Profiler
    Trace = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("tensorflow.profiler.Trace").msgclass
    Device = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("tensorflow.profiler.Device").msgclass
    Resource = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("tensorflow.profiler.Resource").msgclass
    TraceEvent = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("tensorflow.profiler.TraceEvent").msgclass
  end
end
