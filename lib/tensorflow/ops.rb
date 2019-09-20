# keep in alphabetical order
module TensorFlow
  module Ops
    def eye(num_rows,  num_columns: nil)
      num_columns ||= num_rows
      zeros = self.zeros([num_rows, num_columns])
      ones = self.ones([num_rows])
      RawOps.matrix_set_diag(input: zeros, diagonal: ones)
    end

    def fill(dims, value)
      RawOps.fill(dims: dims, value: value)
    end

    def identity(input)
      RawOps.identity(input: input)
    end

    def matmul(a, b)
      RawOps.mat_mul(a: a, b: b)
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
