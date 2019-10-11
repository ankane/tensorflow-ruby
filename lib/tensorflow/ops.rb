# keep in alphabetical order
module Tensorflow
  module Ops
    def cast(x, dtype)
      Utils.execute("Cast", [x], DstT: FFI::DataType[dtype])
    end

    def expand_dims(input, axis)
      RawOps.expand_dims(input: input, dim: axis)
    end

    def fill(dims, value)
      RawOps.fill(dims: dims, value: value)
    end

    def identity(input)
      RawOps.identity(input: input)
    end

    def ones(dims)
      fill(dims, 1)
    end

    def range(start, limit = nil, delta = 1)
      unless limit
        limit = start
        start = 0
      end
      RawOps.range(start: start, limit: limit, delta: delta)
    end

    def reshape(tensor, shape)
      RawOps.reshape(tensor: tensor, shape: shape)
    end

    def squeeze(input, axis: nil)
      RawOps.squeeze(input: input, squeeze_dims: axis)
    end

    def timestamp
      RawOps.timestamp
    end

    def transpose(x, perm: [1, 0])
      RawOps.transpose(x: x, perm: perm)
    end

    def zeros(dims)
      fill(dims, 0)
    end

    def zeros_like(x)
      RawOps.zeros_like(x: x)
    end
  end
end
