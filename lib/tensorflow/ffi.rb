module TensorFlow
  module FFI
    extend ::FFI::Library

    begin
      ffi_lib TensorFlow.ffi_lib
    rescue LoadError => e
      raise e if ENV["TENSORFLOW_DEBUG"]
      raise LoadError, "Could not find TensorFlow"
    end

    class Buffer < ::FFI::Struct
      layout :data, :pointer,
        :length, :size_t,
        :data_deallocator, :pointer
    end

    # https://github.com/tensorflow/tensorflow/blob/master/tensorflow/c/c_api.h
    attach_function :TF_Version, %i[], :string
    attach_function :TF_GetAllOpList, %i[], Buffer.by_ref

    # https://github.com/tensorflow/tensorflow/blob/master/tensorflow/c/tf_attrtype.h
    AttrType = enum(:string, :int, :float, :bool, :type, :shape, :tensor, :placeholder, :func)

    # https://github.com/tensorflow/tensorflow/blob/master/tensorflow/c/tf_datatype.h
    DataType = enum(:float, 1, :double, :int32, :uint8, :int16, :int8, :string, :complex64, :int64, :bool, :qint8, :quint8, :qint32, :bfloat16, :qint16, :quint16, :uint16, :complex128, :half, :resource, :variant, :uint32, :uint64)

    # https://github.com/tensorflow/tensorflow/blob/master/tensorflow/c/tf_status.h
    attach_function :TF_NewStatus, %i[], :pointer
    attach_function :TF_DeleteStatus, %i[pointer], :pointer
    attach_function :TF_GetCode, %i[pointer], :int
    attach_function :TF_Message, %i[pointer], :string

    # https://github.com/tensorflow/tensorflow/blob/master/tensorflow/c/tf_tensor.h
    attach_function :TF_NewTensor, %i[int pointer int pointer size_t pointer pointer], :pointer
    attach_function :TF_DeleteTensor, %i[pointer], :void
    attach_function :TF_TensorData, %i[pointer], :pointer

    # https://github.com/tensorflow/tensorflow/blob/master/tensorflow/c/eager/c_api.h
    attach_function :TFE_NewContextOptions, %i[], :pointer
    attach_function :TFE_ContextOptionsSetAsync, %i[pointer char], :void
    attach_function :TFE_DeleteContextOptions, %i[pointer], :void
    attach_function :TFE_NewContext, %i[pointer pointer], :pointer
    attach_function :TFE_DeleteContext, %i[pointer], :void
    attach_function :TFE_ContextListDevices, %i[pointer pointer], :pointer
    attach_function :TFE_ContextGetDevicePlacementPolicy, %i[pointer], :int
    attach_function :TFE_NewTensorHandle, %i[pointer pointer], :pointer
    attach_function :TFE_DeleteTensorHandle, %i[pointer], :void
    attach_function :TFE_TensorHandleDataType, %i[pointer], :int
    attach_function :TFE_TensorHandleNumDims, %i[pointer pointer], :int
    attach_function :TFE_TensorHandleNumElements, %i[pointer pointer], :int64
    attach_function :TFE_TensorHandleDim, %i[pointer int pointer], :int64
    attach_function :TFE_TensorHandleDeviceName, %i[pointer pointer], :string
    attach_function :TFE_TensorHandleBackingDeviceName, %i[pointer pointer], :string
    attach_function :TFE_TensorHandleResolve, %i[pointer pointer], :pointer
    attach_function :TFE_NewOp, %i[pointer string pointer], :pointer
    attach_function :TFE_DeleteOp, %i[pointer], :void
    attach_function :TFE_OpSetDevice, %i[pointer string pointer], :pointer
    attach_function :TFE_OpGetDevice, %i[pointer pointer], :string
    attach_function :TFE_OpAddInput, %i[pointer pointer pointer], :void
    attach_function :TFE_OpGetAttrType, %i[pointer string pointer pointer], :int
    attach_function :TFE_OpSetAttrString, %i[pointer string pointer size_t], :void
    attach_function :TFE_OpSetAttrInt, %i[pointer string pointer int64_t], :void
    attach_function :TFE_OpSetAttrFloat, %i[pointer string pointer float], :void
    attach_function :TFE_OpSetAttrBool, %i[pointer string uint8], :void
    attach_function :TFE_OpSetAttrType, %i[pointer string int], :void
    attach_function :TFE_OpSetAttrShape, %i[pointer string pointer int pointer], :void
    attach_function :TFE_Execute, %i[pointer pointer pointer pointer], :pointer
  end
end
