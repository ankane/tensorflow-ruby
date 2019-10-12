module Tensorflow
  class Context
    def self.default
      @default ||= Context.new
    end

    def initialize
      options = FFI.TFE_NewContextOptions
      @status = Tensorflow::FFI.TF_NewStatus
      @pointer = FFI.TFE_NewContext(options, @status)
      Operation.check_status @status
      ObjectSpace.define_finalizer(self, self.class.finalize(@pointer))
      FFI.TFE_DeleteContextOptions(options)
    end

    def execute(op_name, inputs = [], **attrs)
      operation = Operation.new(self)
      operation.execute(op_name, inputs, **attrs)
    end

    def function?(name)
      FFI.TFE_ContextHasFunction(@pointer, name) != 0
    end

    def device_policy
      FFI::ContextDevicePlacementPolicy[FFI.TFE_ContextGetDevicePlacementPolicy(@pointer)]
    end

    def enable_run_metadata
      FFI.TFE_ContextEnableRunMetadata(@pointer)
    end

    def disable_run_metadata
      FFI.TFE_ContextDisableRunMetadata(@pointer)
    end

    def start_step
      FFI.TFE_ContextStartStep(@pointer)
    end

    def end_step
      FFI.TFE_ContextEndStep(@pointer)
    end

    def self.finalize(pointer)
      # must use proc instead of stabby lambda
      proc { FFI.TFE_DeleteContext(pointer) }
    end

    def to_ptr
      @pointer
    end

    def shared_name
      # hard-coded in Python library
      "cd2c89b7-88b7-44c8-ad83-06c2a9158347"
    end
  end
end
