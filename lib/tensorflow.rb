# dependencies
require "ffi"
require "npy"

# stdlib
require "fileutils"
require "net/http"
require "tempfile"

# modules
require "tensorflow/utils"
require "tensorflow/context"
require "tensorflow/generated_ops"
require "tensorflow/tensor"
require "tensorflow/variable"
require "tensorflow/version"

# keras
require "tensorflow/keras/datasets/mnist"
require "tensorflow/keras/layers/dense"
require "tensorflow/keras/layers/dropout"
require "tensorflow/keras/layers/flatten"
require "tensorflow/keras/models/sequential"

module TensorFlow
  class Error < StandardError; end

  class << self
    attr_accessor :ffi_lib
  end
  self.ffi_lib = ["tensorflow", "libtensorflow.so"]

  # friendlier error message
  autoload :FFI, "tensorflow/ffi"

  class << self
    include Utils
    include GeneratedOps

    def library_version
      FFI.TF_Version
    end

    def constant(value, dtype: nil, shape: nil)
      Tensor.new(value, dtype: dtype, shape: shape)
    end

    def convert_to_tensor(value, dtype: nil)
      value = Tensor.new(value, dtype: dtype) unless value.is_a?(Tensor)
      value
    end

    def matmul(x, y)
      execute("MatMul", [x, y])
    end

    def transpose(x, perm: [1, 0])
      execute("Transpose", [x, perm])
    end

    def zeros(dims)
      fill(dims, 0)
    end

    def ones(dims)
      fill(dims, 1)
    end

    def assign_add_variable_op(resource, value)
      execute("AssignAddVariableOp", [resource, value])
    end

    def assign_sub_variable_op(resource, value)
      execute("AssignSubVariableOp", [resource, value])
    end

    def assign_variable_op(resource, value)
      execute("AssignVariableOp", [resource, value])
    end

    def read_variable_op(resource, dtype)
      execute("ReadVariableOp", [resource], dtype: dtype)
    end

    def var_handle_op(dtype, shape, container: "", shared_name: "")
      execute("VarHandleOp", [], container: container, shared_name: shared_name, dtype: dtype, shape: shape)
    end

    def var_is_initialized_op(resource)
      execute("VarIsInitializedOp", [resource])
    end

    private

    def default_context
      @default_context ||= Context.new
    end

    def execute(op_name, inputs = [], **attrs)
      context = default_context
      status = FFI.TF_NewStatus # TODO reuse status between ops?
      op = FFI.TFE_NewOp(context, op_name, status)
      check_status status

      attrs.each do |attr_name, attr_value|
        attr_name = attr_name.to_s

        is_list = ::FFI::MemoryPointer.new(:int)
        type = FFI.TFE_OpGetAttrType(op, attr_name, is_list, status)
        check_status status

        case FFI::AttrType[type]
        when :type
          FFI.TFE_OpSetAttrType(op, attr_name, attr_value)
        when :shape
          # TODO set value properly
          FFI.TFE_OpSetAttrShape(op, attr_name, attr_value, 0, status)
          check_status status
        when :string
          FFI.TFE_OpSetAttrString(op, attr_name, attr_value, attr_value.bytesize)
        else
          raise "Unknown type: #{FFI::AttrType[type]}"
        end
      end

      inputs.each do |input|
        input = convert_to_tensor(input) unless input.respond_to?(:to_ptr)
        FFI.TFE_OpAddInput(op, input, status)
        check_status status
      end

      retvals = ::FFI::MemoryPointer.new(:pointer)
      num_retvals = ::FFI::MemoryPointer.new(:int)
      num_retvals.write_int(retvals.size)
      FFI.TFE_Execute(op, retvals, num_retvals, status)
      check_status status

      if num_retvals.read_int > 0
        handle = retvals.read_pointer
        type = FFI.TFE_TensorHandleDataType(handle)

        case FFI::DataType[type]
        when :resource
          handle
        else
          Tensor.new(pointer: handle)
        end
      end
    ensure
      FFI.TF_DeleteStatus(status) if status
      FFI.TFE_DeleteOp(op) if op
    end

    def check_status(status)
      Utils.check_status(status)
    end
  end
end

# shortcut
Tf = TensorFlow
