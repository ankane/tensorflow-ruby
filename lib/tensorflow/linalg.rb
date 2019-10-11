module Tensorflow
  module Linalg
    class << self
      # def adjoint
      # end

      # def band_part
      # end

      def cholesky(input)
        RawOps.cholesky(input: input)
      end

      # def cholesky_solve
      # end

      def cross(a, b)
        RawOps.cross(a: a, b: b)
      end

      # def det
      # end

      def diag(diagonal)
        RawOps.diag(diagonal: diagonal)
      end

      def diag_part(input)
        RawOps.diag_part(input: input)
      end

      # def eigh
      # end

      # def eigvalsh
      # end

      # def einsum
      # end

      # def expm
      # end

      def eye(num_rows, num_columns: nil)
        num_columns ||= num_rows
        zeros = Tensorflow.zeros([num_rows, num_columns])
        ones = Tensorflow.ones([num_rows])
        RawOps.matrix_set_diag(input: zeros, diagonal: ones)
      end

      # def global_norm
      # end

      def inv(x)
        RawOps.inv(x: x)
      end

      # def l2_normalize
      # end

      # def logdet
      # end

      # def logm
      # end

      # def lstsq
      # end

      def lu(input, output_idx_type: nil)
        RawOps.lu(input: input, output_idx_type: output_idx_type)
      end

      def matmul(a, b, transpose_a: false, transpose_b: false)
        RawOps.mat_mul(a: a, b: b, transpose_a: transpose_a, transpose_b: transpose_b)
      end

      # def matrix_transpose
      # end

      # def matvec
      # end

      # def norm
      # end

      # def normalize
      # end

      def qr(input, full_matrices: nil)
        RawOps.qr(input: input, full_matrices: full_matrices)
      end

      # def set_diag
      # end

      # def slogdet
      # end

      # def solve
      # end

      # def sqrtm
      # end

      def svd(input, compute_uv: nil, full_matrices: nil)
        RawOps.svd(input: input, compute_uv: compute_uv, full_matrices: full_matrices)
      end

      # def tensor_diag
      # end

      # def tensor_diag_part
      # end

      # def tensordot
      # end

      # def trace
      # end

      # def triangular_solve
      # end

      # def tridiagonal_matmul
      # end

      def tridiagonal_solve(diagonals, rhs, partial_pivoting: nil)
        RawOps.tridiagonal_solve(diagonals: diagonals, rhs: rhs, partial_pivoting: partial_pivoting)
      end
    end
  end
end
