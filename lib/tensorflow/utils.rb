module TensorFlow
  module Utils
    def self.check_status(status)
      if FFI.TF_GetCode(status) != 0
        raise Error, FFI.TF_Message(status)
      end
    end

    def self.infer_type(value)
      case value
      when String
        :string
      when Float
        :float
      when true, false
        :bool
      else
        :int32
      end
    end
  end
end
