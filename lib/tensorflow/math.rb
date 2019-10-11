module Tensorflow
  module Math
    class << self
      def abs(x)
        RawOps.abs(x: x)
      end

      # def accumulate_n
      # end

      def acos(x)
        RawOps.acos(x: x)
      end

      def acosh(x)
        RawOps.acosh(x: x)
      end

      def add(x, y)
        RawOps.add(x: x, y: y)
      end

      def add_n(inputs)
        RawOps.add_n(inputs: inputs)
      end

      def angle(input)
        RawOps.angle(input: input)
      end

      # def argmax
      # end

      # def argmin
      # end

      def asin(x)
        RawOps.asin(x: x)
      end

      def asinh(x)
        RawOps.asinh(x: x)
      end

      def atan(x)
        RawOps.atan(x: x)
      end

      def atan2(y, x)
        RawOps.atan2(y: y, x: x)
      end

      def atanh(x)
        RawOps.atanh(x: x)
      end

      # def bessel_i0
      # end

      def bessel_i0e(x)
        RawOps.bessel_i0e(x: x)
      end

      # def bessel_i1
      # end

      def bessel_i1e(x)
        RawOps.bessel_i1e(x: x)
      end

      def betainc(a, b, x)
        RawOps.betainc(a: a, b: b, x: x)
      end

      def bincount(arr, size, weights)
        RawOps.bincount(arr: arr, size: size, weights: weights)
      end

      def ceil(x)
        RawOps.ceil(x: x)
      end

      # def confusion_matrix
      # end

      def conj(input)
        RawOps.conj(input: input)
      end

      def cos(x)
        RawOps.cos(x: x)
      end

      def cosh(x)
        RawOps.cosh(x: x)
      end

      # def count_nonzero
      # end

      def cumprod(x, axis, exclusive: nil, reverse: nil)
        RawOps.cumprod(x: x, axis: axis, exclusive: exclusive, reverse: reverse)
      end

      def cumsum(x, axis, exclusive: nil, reverse: nil)
        RawOps.cumsum(x: x, axis: axis, exclusive: exclusive, reverse: reverse)
      end

      # def cumulative_logsumexp
      # end

      def digamma(x)
        RawOps.digamma(x: x)
      end

      def divide(x, y)
        RawOps.div(x: x, y: y)
      end

      # def divide_no_nan
      # end

      def equal(x, y)
        RawOps.equal(x: x, y: y)
      end

      def erf(x)
        RawOps.erf(x: x)
      end

      def erfc(x)
        RawOps.erfc(x: x)
      end

      def exp(x)
        RawOps.exp(x: x)
      end

      def expm1(x)
        RawOps.expm1(x: x)
      end

      def floor(x)
        RawOps.floor(x: x)
      end

      def floordiv(x, y)
        RawOps.floor_div(x: x, y: y)
      end

      def floormod(x, y)
        RawOps.floor_mod(x: x, y: y)
      end

      def greater(x, y)
        RawOps.greater(x: x, y: y)
      end

      def greater_equal(x, y)
        RawOps.greater_equal(x: x, y: y)
      end

      def igamma(a, x)
        RawOps.igamma(a: a, x: x)
      end

      def igammac(a, x)
        RawOps.igammac(a: a, x: x)
      end

      def imag(input)
        RawOps.imag(input: input)
      end

      def in_top_k(predictions, targets, k: nil)
        RawOps.in_top_k(predictions: predictions, targets: targets, k: k)
      end

      def invert_permutation(x)
        RawOps.invert_permutation(x: x)
      end

      def is_finite(x)
        RawOps.is_finite(x: x)
      end

      def is_inf(x)
        RawOps.is_inf(x: x)
      end

      def is_nan(x)
        RawOps.is_nan(x: x)
      end

      # def is_non_decreasing
      # end

      # def is_strictly_increasing
      # end

      # def l2_normalize
      # end

      # def lbeta
      # end

      def less(x, y)
        RawOps.less(x: x, y: y)
      end

      def less_equal(x, y)
        RawOps.less_equal(x: x, y: y)
      end

      def lgamma(x)
        RawOps.lgamma(x: x)
      end

      def log(x)
        RawOps.log(x: x)
      end

      def log1p(x)
        RawOps.log1p(x: x)
      end

      def log_sigmoid(x)
        x = Tensorflow.convert_to_tensor(x)
        negative(RawOps.softplus(features: -x))
      end

      def log_softmax(logits)
        RawOps.log_softmax(logits: logits)
      end

      def logical_and(x, y)
        RawOps.logical_and(x: x, y: y)
      end

      def logical_not(x)
        RawOps.logical_not(x: x)
      end

      def logical_or(x, y)
        RawOps.logical_or(x: x, y: y)
      end

      def logical_xor(x, y)
        logical_and(logical_or(x, y), logical_not(logical_and(x, y)))
      end

      def maximum(x, y)
        RawOps.maximum(x: x, y: y)
      end

      def minimum(x, y)
        RawOps.minimum(x: x, y: y)
      end

      def mod(x, y)
        RawOps.mod(x: x, y: y)
      end

      def multiply(x, y)
        RawOps.mul(x: x, y: y)
      end

      def multiply_no_nan(x, y)
        RawOps.mul_no_nan(x: x, y: y)
      end

      def negative(x)
        RawOps.neg(x: x)
      end

      # def nextafter
      # end

      def not_equal(x, y)
        RawOps.not_equal(x: x, y: y)
      end

      def polygamma(a, x)
        RawOps.polygamma(a: a, x: x)
      end

      # def polyval
      # end

      def pow(x, y)
        RawOps.pow(x: x, y: y)
      end

      def real(input)
        RawOps.real(input: input)
      end

      def reciprocal(x)
        RawOps.reciprocal(x: x)
      end

      # def reciprocal_no_nan
      # end

      # def reduce_all
      # end

      def reduce_any(input_tensor, axis: nil, keepdims: false)
        input_tensor = Tensorflow.convert_to_tensor(input_tensor)
        axis ||= reduction_dims(input_tensor)
        RawOps.any(input: input_tensor, reduction_indices: axis, keep_dims: keepdims)
      end

      # def reduce_euclidean_norm
      # end

      # def reduce_logsumexp
      # end

      def reduce_max(input_tensor, axis: nil, keepdims: false)
        input_tensor = Tensorflow.convert_to_tensor(input_tensor)
        axis ||= reduction_dims(input_tensor)
        RawOps.max(input: input_tensor, reduction_indices: axis, keep_dims: keepdims)
      end

      def reduce_mean(input_tensor, axis: nil, keepdims: false)
        input_tensor = Tensorflow.convert_to_tensor(input_tensor)
        axis ||= reduction_dims(input_tensor)
        RawOps.mean(input: input_tensor, reduction_indices: axis, keep_dims: keepdims)
      end

      def reduce_min(input_tensor, axis: nil, keepdims: false)
        input_tensor = Tensorflow.convert_to_tensor(input_tensor)
        axis ||= reduction_dims(input_tensor)
        RawOps.min(input: input_tensor, reduction_indices: axis, keep_dims: keepdims)
      end

      def reduce_prod(input_tensor, axis: nil, keepdims: false)
        input_tensor = Tensorflow.convert_to_tensor(input_tensor)
        axis ||= reduction_dims(input_tensor)
        RawOps.prod(input: input_tensor, reduction_indices: axis, keep_dims: keepdims)
      end

      def reduce_std(input_tensor, axis: nil, keepdims: false)
        variance = reduce_variance(input_tensor, axis: axis, keepdims: keepdims)
        sqrt(variance)
      end

      def reduce_sum(input_tensor, axis: nil, keepdims: false)
        input_tensor = Tensorflow.convert_to_tensor(input_tensor)
        axis ||= reduction_dims(input_tensor)
        RawOps.sum(input: input_tensor, reduction_indices: axis, keep_dims: keepdims)
      end

      def reduce_variance(input_tensor, axis: nil, keepdims: false)
        means = reduce_mean(input_tensor, axis: axis, keepdims: true)
        squared_deviations = RawOps.square(x: input_tensor - means)
        reduce_mean(squared_deviations, axis: axis, keepdims: keepdims)
      end

      def rint(x)
        RawOps.rint(x: x)
      end

      def round(x)
        RawOps.round(x: x)
      end

      def rsqrt(x)
        RawOps.rsqrt(x: x)
      end

      # def scalar_mul
      # end

      def segment_max(data, segment_ids)
        RawOps.segment_max(data: data, segment_ids: segment_ids)
      end

      def segment_mean(data, segment_ids)
        RawOps.segment_mean(data: data, segment_ids: segment_ids)
      end

      def segment_min(data, segment_ids)
        RawOps.segment_min(data: data, segment_ids: segment_ids)
      end

      def segment_prod(data, segment_ids)
        RawOps.segment_prod(data: data, segment_ids: segment_ids)
      end

      def segment_sum(data, segment_ids)
        RawOps.segment_sum(data: data, segment_ids: segment_ids)
      end

      def sigmoid(x)
        RawOps.sigmoid(x: x)
      end

      def sign(x)
        RawOps.sign(x: x)
      end

      def sin(x)
        RawOps.sin(x: x)
      end

      def sinh(x)
        RawOps.sinh(x: x)
      end

      def softmax(logits)
        RawOps.softmax(logits: logits)
      end

      def softplus(features)
        RawOps.softplus(features: features)
      end

      def softsign(features)
        RawOps.softsign(features: features)
      end

      def sqrt(x)
        RawOps.sqrt(x: x)
      end

      def square(x)
        RawOps.square(x: x)
      end

      def squared_difference(x, y)
        RawOps.squared_difference(x: x, y: y)
      end

      def subtract(x, y)
        RawOps.sub(x: x, y: y)
      end

      def tan(x)
        RawOps.tan(x: x)
      end

      def tanh(x)
        RawOps.tanh(x: x)
      end

      def top_k(input, k: nil, sorted: nil)
        RawOps.top_k(input: input, k: k, sorted: sorted)
      end

      # def truediv
      # end

      def unsorted_segment_max(data, segment_ids, num_segments)
        RawOps.unsorted_segment_max(data: data, segment_ids: segment_ids, num_segments: num_segments)
      end

      # def unsorted_segment_mean
      # end

      def unsorted_segment_min(data, segment_ids, num_segments)
        RawOps.unsorted_segment_min(data: data, segment_ids: segment_ids, num_segments: num_segments)
      end

      def unsorted_segment_prod(data, segment_ids, num_segments)
        RawOps.unsorted_segment_prod(data: data, segment_ids: segment_ids, num_segments: num_segments)
      end

      # def unsorted_segment_sqrt_n
      # end

      def unsorted_segment_sum(data, segment_ids, num_segments)
        RawOps.unsorted_segment_sum(data: data, segment_ids: segment_ids, num_segments: num_segments)
      end

      def xdivy(x, y)
        RawOps.xdivy(x: x, y: y)
      end

      def xlogy(x, y)
        RawOps.xlogy(x: x, y: y)
      end

      # def zero_fraction
      # end

      def zeta(x, q)
        RawOps.zeta(x: x, q: q)
      end

      private

      def reduction_dims(input_tensor)
        rank = RawOps.rank(input: input_tensor).value
        Tensorflow.constant((0...rank).to_a, dtype: :int32)
      end
    end
  end
end
