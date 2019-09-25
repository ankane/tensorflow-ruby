module TensorFlow
  class Context
    def initialize
      options = FFI.TFE_NewContextOptions
      @status = TensorFlow::FFI.TF_NewStatus
      @pointer = FFI.TFE_NewContext(options, @status)
      Utils.check_status @status
      ObjectSpace.define_finalizer(self, self.class.finalize(@pointer))
      FFI.TFE_DeleteContextOptions(options)
    end

    def start_step
      FFI.TFE_ContextStartStep(@pointer)
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
