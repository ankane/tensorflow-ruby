# dependencies
require "ffi"
require "npy"
require "numo/narray"

# stdlib
require "digest"
require "fileutils"
require "forwardable"
require "json"
require "net/http"
require "tempfile"
require "zlib"

# Load protobufs. Is this a good idea to require all ruby files in those directories?
Dir[File.join(__dir__, 'tensorflow', 'core', 'lib', 'core', '*.rb')].each { |file| require file }
Dir[File.join(__dir__, 'tensorflow', 'core', 'stream_executor', '*.rb')].each { |file| require file }
Dir[File.join(__dir__, 'tensorflow', 'core', 'framework', '*.rb')].each { |file| require file }
#Dir[File.join(__dir__, 'tensorflow', 'core', 'protobuf', '*.rb')].each { |file| require file }

# modules
require "tensorflow/audio"
require "tensorflow/bitwise"
require "tensorflow/context"
require "tensorflow/image"
require "tensorflow/io"
require "tensorflow/linalg"
require "tensorflow/math"
require "tensorflow/nn"
require "tensorflow/operation"
require "tensorflow/ops"
require "tensorflow/random"
require "tensorflow/raw_ops"
require "tensorflow/strings"
require "tensorflow/tensor"
require "tensorflow/utils"
require "tensorflow/variable"
require "tensorflow/version"

# specs
require "tensorflow/type_spec"
require "tensorflow/batchable_type_spec"
require "tensorflow/tensor_spec"

# data
require "tensorflow/data/dataset"
require "tensorflow/data/batch_dataset"
require "tensorflow/data/fixed_length_record_dataset"
require "tensorflow/data/map_dataset"
require "tensorflow/data/repeat_dataset"
require "tensorflow/data/shuffle_dataset"
require "tensorflow/data/tensor_dataset"
require "tensorflow/data/tensor_slice_dataset"
require "tensorflow/data/zip_dataset"

# keras
require "tensorflow/keras/datasets/boston_housing"
require "tensorflow/keras/datasets/cifar10"
require "tensorflow/keras/datasets/cifar100"
require "tensorflow/keras/datasets/fashion_mnist"
require "tensorflow/keras/datasets/imdb"
require "tensorflow/keras/datasets/mnist"
require "tensorflow/keras/datasets/reuters"
require "tensorflow/keras/layers/conv"
require "tensorflow/keras/layers/conv2d"
require "tensorflow/keras/layers/dense"
require "tensorflow/keras/layers/dropout"
require "tensorflow/keras/layers/flatten"
require "tensorflow/keras/losses/sparse_categorical_crossentropy"
require "tensorflow/keras/metrics/mean"
require "tensorflow/keras/metrics/sparse_categorical_accuracy"
require "tensorflow/keras/model"
require "tensorflow/keras/models/sequential"
require "tensorflow/keras/optimizers/adam"
require "tensorflow/keras/preprocessing/image"
require "tensorflow/keras/utils"

require 'tensorflow/core/framework/op_def_pb'

# We can't use Tensorflow::Error because a protobuf message annoyingly assigns that as a module
class TensorflowError < StandardError
end

module Tensorflow
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
    def_delegators Linalg, :eye, :matmul
    def_delegators Math, :abs, :acos, :acosh, :add, :add_n, :argmax, :argmin, :asin, :asinh, :atan, :atan2, :atanh, :cos, :cosh, :cumsum, :divide, :equal, :exp, :floor, :greater, :greater_equal, :less, :less_equal, :logical_and, :logical_not, :logical_or, :maximum, :minimum, :multiply, :negative, :not_equal, :pow, :reduce_all, :reduce_any, :reduce_logsumexp, :reduce_max, :reduce_mean, :reduce_min, :reduce_prod, :reduce_sum, :round, :scalar_mul, :sigmoid, :sign, :sin, :sinh, :sqrt, :square, :subtract, :tan, :tanh, :truediv
    def_delegators NN, :space_to_batch
    def_delegators Tensor, :constant, :placeholder

    def library_version
      FFI.TF_Version
    end

    def convert_to_tensor(value, dtype: nil)
      case value
        when Tensor
          value
        when Variable
          value
        else
          value = Tensor.new(value, dtype: dtype) unless value.is_a?(Tensor)
          if dtype && value.dtype != dtype
            raise StandardError, "Tensor conversion requested dtype #{dtype} for Tensor with dtype #{value.dtype}"
          end
          value
      end
    end
  end
end

# shortcut
Tf = Tensorflow
