module Tensorflow
  module NN
    class << self
      def all_candidate_sampler(true_classes, num_true: nil, num_sampled: nil, unique: nil, seed: nil, seed2: nil)
        RawOps.all_candidate_sampler(true_classes: true_classes, num_true: num_true, num_sampled: num_sampled, unique: unique, seed: seed, seed2: seed2)
      end

      # def atrous_conv2d
      # end

      # def atrous_conv2d_transpose
      # end

      def avg_pool(value, ksize: nil, strides: nil, padding: nil, data_format: nil)
        RawOps.avg_pool(value: value, ksize: ksize, strides: strides, padding: padding, data_format: data_format)
      end

      # def avg_pool1d
      # end

      # def avg_pool2d
      # end

      def avg_pool3d(input, ksize: nil, strides: nil, padding: nil, data_format: nil)
        RawOps.avg_pool3d(input: input, ksize: ksize, strides: strides, padding: padding, data_format: data_format)
      end

      def batch_norm_with_global_normalization(t, m, v, beta, gamma, variance_epsilon: nil, scale_after_normalization: nil)
        RawOps.batch_norm_with_global_normalization(t: t, m: m, v: v, beta: beta, gamma: gamma, variance_epsilon: variance_epsilon, scale_after_normalization: scale_after_normalization)
      end

      # def batch_normalization
      # end

      def bias_add(value, bias, data_format: nil)
        RawOps.bias_add(value: value, bias: bias, data_format: data_format)
      end

      # def collapse_repeated
      # end

      def compute_accidental_hits(true_classes, sampled_candidates, num_true: nil, seed: nil, seed2: nil)
        RawOps.compute_accidental_hits(true_classes: true_classes, sampled_candidates: sampled_candidates, num_true: num_true, seed: seed, seed2: seed2)
      end

      # def compute_average_loss
      # end

      # def conv1d
      # end

      # def conv1d_transpose
      # end

      def conv2d(input, filter, strides: nil, use_cudnn_on_gpu: nil, padding: nil, explicit_paddings: nil, data_format: nil, dilations: nil)
        RawOps.conv2d(input: input, filter: filter, strides: strides, use_cudnn_on_gpu: use_cudnn_on_gpu, padding: padding, explicit_paddings: explicit_paddings, data_format: data_format, dilations: dilations)
      end

      # def conv2d_transpose
      # end

      def conv3d(input, filter, strides: nil, padding: nil, data_format: nil, dilations: nil)
        RawOps.conv3d(input: input, filter: filter, strides: strides, padding: padding, data_format: data_format, dilations: dilations)
      end

      # def conv3d_transpose
      # end

      # def conv_transpose
      # end

      # def convolution
      # end

      # def crelu
      # end

      def ctc_beam_search_decoder(inputs, sequence_length, beam_width: nil, top_paths: nil, merge_repeated: nil)
        RawOps.ctc_beam_search_decoder(inputs: inputs, sequence_length: sequence_length, beam_width: beam_width, top_paths: top_paths, merge_repeated: merge_repeated)
      end

      def ctc_greedy_decoder(inputs, sequence_length, merge_repeated: nil)
        RawOps.ctc_greedy_decoder(inputs: inputs, sequence_length: sequence_length, merge_repeated: merge_repeated)
      end

      def ctc_loss(inputs, labels_indices, labels_values, sequence_length, preprocess_collapse_repeated: nil, ctc_merge_repeated: nil, ignore_longer_outputs_than_inputs: nil)
        RawOps.ctc_loss(inputs: inputs, labels_indices: labels_indices, labels_values: labels_values, sequence_length: sequence_length, preprocess_collapse_repeated: preprocess_collapse_repeated, ctc_merge_repeated: ctc_merge_repeated, ignore_longer_outputs_than_inputs: ignore_longer_outputs_than_inputs)
      end

      # def ctc_unique_labels
      # end

      def depth_to_space(input, block_size: nil, data_format: nil)
        RawOps.depth_to_space(input: input, block_size: block_size, data_format: data_format)
      end

      # def depthwise_conv2d
      # end

      # def depthwise_conv2d_backprop_filter
      # end

      # def depthwise_conv2d_backprop_input
      # end

      def dilation2d(input, filter, strides: nil, rates: nil, padding: nil)
        RawOps.dilation2d(input: input, filter: filter, strides: strides, rates: rates, padding: padding)
      end

      # def dropout
      # end

      def elu(features)
        RawOps.elu(features: features)
      end

      # def embedding_lookup
      # end

      # def embedding_lookup_sparse
      # end

      # def erosion2d
      # end

      def fixed_unigram_candidate_sampler(true_classes, num_true: nil, num_sampled: nil, unique: nil, range_max: nil, vocab_file: nil, distortion: nil, num_reserved_ids: nil, num_shards: nil, shard: nil, unigrams: nil, seed: nil, seed2: nil)
        RawOps.fixed_unigram_candidate_sampler(true_classes: true_classes, num_true: num_true, num_sampled: num_sampled, unique: unique, range_max: range_max, vocab_file: vocab_file, distortion: distortion, num_reserved_ids: num_reserved_ids, num_shards: num_shards, shard: shard, unigrams: unigrams, seed: seed, seed2: seed2)
      end

      def fractional_avg_pool(value, pooling_ratio: nil, pseudo_random: nil, overlapping: nil, deterministic: nil, seed: nil, seed2: nil)
        RawOps.fractional_avg_pool(value: value, pooling_ratio: pooling_ratio, pseudo_random: pseudo_random, overlapping: overlapping, deterministic: deterministic, seed: seed, seed2: seed2)
      end

      def fractional_max_pool(value, pooling_ratio: nil, pseudo_random: nil, overlapping: nil, deterministic: nil, seed: nil, seed2: nil)
        RawOps.fractional_max_pool(value: value, pooling_ratio: pooling_ratio, pseudo_random: pseudo_random, overlapping: overlapping, deterministic: deterministic, seed: seed, seed2: seed2)
      end

      def in_top_k(predictions, targets, k: nil)
        RawOps.in_top_k(predictions: predictions, targets: targets, k: k)
      end

      def l2_loss(t)
        RawOps.l2_loss(t: t)
      end

      # def l2_normalize
      # end

      def leaky_relu(features, alpha: nil)
        RawOps.leaky_relu(features: features, alpha: alpha)
      end

      def learned_unigram_candidate_sampler(true_classes, num_true: nil, num_sampled: nil, unique: nil, range_max: nil, seed: nil, seed2: nil)
        RawOps.learned_unigram_candidate_sampler(true_classes: true_classes, num_true: num_true, num_sampled: num_sampled, unique: unique, range_max: range_max, seed: seed, seed2: seed2)
      end

      # def local_response_normalization
      # end

      # def log_poisson_loss
      # end

      def log_softmax(logits)
        RawOps.log_softmax(logits: logits)
      end

      def lrn(input, depth_radius: nil, bias: nil, alpha: nil, beta: nil)
        RawOps.lrn(input: input, depth_radius: depth_radius, bias: bias, alpha: alpha, beta: beta)
      end

      def max_pool(input, ksize: nil, strides: nil, padding: nil, data_format: nil)
        RawOps.max_pool(input: input, ksize: ksize, strides: strides, padding: padding, data_format: data_format)
      end

      # def max_pool1d
      # end

      # def max_pool2d
      # end

      def max_pool3d(input, ksize: nil, strides: nil, padding: nil, data_format: nil)
        RawOps.max_pool3d(input: input, ksize: ksize, strides: strides, padding: padding, data_format: data_format)
      end

      def max_pool_with_argmax(input, ksize: nil, strides: nil, padding: nil, include_batch_in_index: nil)
        RawOps.max_pool_with_argmax(input: input, ksize: ksize, strides: strides, padding: padding, include_batch_in_index: include_batch_in_index)
      end

      # def moments
      # end

      # def nce_loss
      # end

      # def normalize_moments
      # end

      # def pool
      # end

      def relu(features)
        RawOps.relu(features: features)
      end

      def relu6(features)
        RawOps.relu6(features: features)
      end

      # def safe_embedding_lookup_sparse
      # end

      # def sampled_softmax_loss
      # end

      # def scale_regularization_loss
      # end

      def selu(features)
        RawOps.selu(features: features)
      end

      # def separable_conv2d
      # end

      def sigmoid(x)
        RawOps.sigmoid(x: x)
      end

      # def sigmoid_cross_entropy_with_logits
      # end

      def softmax(logits)
        RawOps.softmax(logits: logits)
      end

      def softmax_cross_entropy_with_logits(features, labels)
        RawOps.softmax_cross_entropy_with_logits(features: features, labels: labels)
      end

      def softplus(features)
        RawOps.softplus(features: features)
      end

      def softsign(features)
        RawOps.softsign(features: features)
      end

      def space_to_batch(input, paddings, block_size: nil)
        RawOps.space_to_batch(input: input, paddings: paddings, block_size: block_size)
      end

      def space_to_depth(input, block_size: nil, data_format: nil)
        RawOps.space_to_depth(input: input, block_size: block_size, data_format: data_format)
      end

      def sparse_softmax_cross_entropy_with_logits(features, labels)
        RawOps.sparse_softmax_cross_entropy_with_logits(features: features, labels: labels)
      end

      # def sufficient_statistics
      # end

      def tanh(x)
        RawOps.tanh(x: x)
      end

      def top_k(input, k: nil, sorted: nil)
        RawOps.top_k(input: input, k: k, sorted: sorted)
      end

      # def weighted_cross_entropy_with_logits
      # end

      # def weighted_moments
      # end

      # def with_space_to_batch
      # end

      # def zero_fraction
      # end
    end
  end
end
