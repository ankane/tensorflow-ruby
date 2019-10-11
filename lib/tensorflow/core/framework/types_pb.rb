# Generated by the protocol buffer compiler.  DO NOT EDIT!
# source: tensorflow/core/framework/types.proto

require 'google/protobuf'

Google::Protobuf::DescriptorPool.generated_pool.build do
  add_file("tensorflow/core/framework/types.proto", :syntax => :proto3) do
    add_enum "tensorflow.DataType" do
      value :DT_INVALID, 0
      value :DT_FLOAT, 1
      value :DT_DOUBLE, 2
      value :DT_INT32, 3
      value :DT_UINT8, 4
      value :DT_INT16, 5
      value :DT_INT8, 6
      value :DT_STRING, 7
      value :DT_COMPLEX64, 8
      value :DT_INT64, 9
      value :DT_BOOL, 10
      value :DT_QINT8, 11
      value :DT_QUINT8, 12
      value :DT_QINT32, 13
      value :DT_BFLOAT16, 14
      value :DT_QINT16, 15
      value :DT_QUINT16, 16
      value :DT_UINT16, 17
      value :DT_COMPLEX128, 18
      value :DT_HALF, 19
      value :DT_RESOURCE, 20
      value :DT_VARIANT, 21
      value :DT_UINT32, 22
      value :DT_UINT64, 23
      value :DT_FLOAT_REF, 101
      value :DT_DOUBLE_REF, 102
      value :DT_INT32_REF, 103
      value :DT_UINT8_REF, 104
      value :DT_INT16_REF, 105
      value :DT_INT8_REF, 106
      value :DT_STRING_REF, 107
      value :DT_COMPLEX64_REF, 108
      value :DT_INT64_REF, 109
      value :DT_BOOL_REF, 110
      value :DT_QINT8_REF, 111
      value :DT_QUINT8_REF, 112
      value :DT_QINT32_REF, 113
      value :DT_BFLOAT16_REF, 114
      value :DT_QINT16_REF, 115
      value :DT_QUINT16_REF, 116
      value :DT_UINT16_REF, 117
      value :DT_COMPLEX128_REF, 118
      value :DT_HALF_REF, 119
      value :DT_RESOURCE_REF, 120
      value :DT_VARIANT_REF, 121
      value :DT_UINT32_REF, 122
      value :DT_UINT64_REF, 123
    end
  end
end

module Tensorflow
  DataType = ::Google::Protobuf::DescriptorPool.generated_pool.lookup("tensorflow.DataType").enummodule
end
