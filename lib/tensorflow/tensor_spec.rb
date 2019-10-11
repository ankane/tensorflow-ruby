module Tensorflow
  class TensorSpec < BatchableTypeSpec
    attr_reader :shape, :dtype

    def initialize(shape, dtype)
      @shape = shape
      @dtype = dtype
    end
  end
end