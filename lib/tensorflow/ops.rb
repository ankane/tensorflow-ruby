# keep in alphabetical order
module TensorFlow
  module Ops
    def eye(num_rows,  num_columns: nil)
      num_columns ||= num_rows
      zeros = self.zeros([num_rows, num_columns])
      ones = self.ones([num_rows])
      matrix_set_diag(zeros, ones)
    end

    def matmul(x, y)
      execute("MatMul", [x, y])
    end

    def ones(dims)
      fill(dims, 1)
    end

    def range(start, limit = nil, delta = 1)
      unless limit
        limit = start
        start = 0
      end
      super(start, limit, delta)
    end

    def transpose(x, perm: [1, 0])
      execute("Transpose", [x, perm])
    end

    def zeros(dims)
      fill(dims, 0)
    end
  end
end
