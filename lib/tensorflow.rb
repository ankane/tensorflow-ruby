# dependencies
require "ffi"
require "npy"
require "numo/narray"

# stdlib
require "fileutils"
require "forwardable"
require "json"
require "net/http"
require "tempfile"

# modules
require "tensorflow/audio"
require "tensorflow/bitwise"
require "tensorflow/context"
require "tensorflow/image"
require "tensorflow/io"
require "tensorflow/linalg"
require "tensorflow/math"
require "tensorflow/ops"
require "tensorflow/raw_ops"
require "tensorflow/strings"
require "tensorflow/tensor"
require "tensorflow/utils"
require "tensorflow/variable"
require "tensorflow/version"

# keras
require "tensorflow/keras/datasets/boston_housing"
require "tensorflow/keras/datasets/imdb"
require "tensorflow/keras/datasets/mnist"
require "tensorflow/keras/datasets/reuters"
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
    include Ops
    include Utils

    extend Forwardable
    def_delegators Linalg, :matmul
    def_delegators Math, :abs, :acos, :acosh, :add, :add_n, :argmax, :argmin, :asin, :asinh, :atan, :atan2, :atanh, :cos, :cosh, :cumsum, :divide, :equal, :exp, :floor, :greater, :greater_equal, :less, :less_equal, :logical_and, :logical_not, :logical_or, :maximum, :minimum, :multiply, :negative, :not_equal, :pow, :reduce_all, :reduce_any, :reduce_logsumexp, :reduce_max, :reduce_mean, :reduce_min, :reduce_prod, :reduce_sum, :round, :scalar_mul, :sigmoid, :sign, :sin, :sinh, :sqrt, :square, :subtract, :tan, :tanh, :truediv

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
  end
end

# shortcut
Tf = TensorFlow
