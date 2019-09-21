module TensorFlow
  module Image
    class << self
      # def adjust_brightness
      # end

      def adjust_contrast(images, contrast_factor, min_value, max_value)
        RawOps.adjust_contrast(images: images, contrast_factor: contrast_factor, min_value: min_value, max_value: max_value)
      end

      # def adjust_gamma
      # end

      def adjust_hue(images, delta)
        RawOps.adjust_hue(images: images, delta: delta)
      end

      # def adjust_jpeg_quality
      # end

      def adjust_saturation(images, scale)
        RawOps.adjust_saturation(images: images, scale: scale)
      end

      # def central_crop
      # end

      def combined_non_max_suppression(boxes, scores, max_output_size_per_class, max_total_size, iou_threshold, score_threshold, pad_per_class: nil, clip_boxes: nil)
        RawOps.combined_non_max_suppression(boxes: boxes, scores: scores, max_output_size_per_class: max_output_size_per_class, max_total_size: max_total_size, iou_threshold: iou_threshold, score_threshold: score_threshold, pad_per_class: pad_per_class, clip_boxes: clip_boxes)
      end

      # def convert_image_dtype
      # end

      def crop_and_resize(image, boxes, box_ind, crop_size, method: nil, extrapolation_value: nil)
        RawOps.crop_and_resize(image: image, boxes: boxes, box_ind: box_ind, crop_size: crop_size, method: method, extrapolation_value: extrapolation_value)
      end

      # def crop_to_bounding_box
      # end

      def decode_and_crop_jpeg(contents, crop_window, channels: nil, ratio: nil, fancy_upscaling: nil, try_recover_truncated: nil, acceptable_fraction: nil, dct_method: nil)
        RawOps.decode_and_crop_jpeg(contents: contents, crop_window: crop_window, channels: channels, ratio: ratio, fancy_upscaling: fancy_upscaling, try_recover_truncated: try_recover_truncated, acceptable_fraction: acceptable_fraction, dct_method: dct_method)
      end

      def decode_bmp(contents, channels: nil)
        RawOps.decode_bmp(contents: contents, channels: channels)
      end

      def decode_gif(contents)
        RawOps.decode_gif(contents: contents)
      end

      # def decode_image
      # end

      def decode_jpeg(contents, channels: nil, ratio: nil, fancy_upscaling: nil, try_recover_truncated: nil, acceptable_fraction: nil, dct_method: nil)
        RawOps.decode_jpeg(contents: contents, channels: channels, ratio: ratio, fancy_upscaling: fancy_upscaling, try_recover_truncated: try_recover_truncated, acceptable_fraction: acceptable_fraction, dct_method: dct_method)
      end

      def decode_png(contents, channels: nil, dtype: nil)
        RawOps.decode_png(contents: contents, channels: channels, dtype: dtype)
      end

      def draw_bounding_boxes(images, boxes)
        RawOps.draw_bounding_boxes(images: images, boxes: boxes)
      end

      def encode_jpeg(image, format: nil, quality: nil, progressive: nil, optimize_size: nil, chroma_downsampling: nil, density_unit: nil, x_density: nil, y_density: nil, xmp_metadata: nil)
        RawOps.encode_jpeg(image: image, format: format, quality: quality, progressive: progressive, optimize_size: optimize_size, chroma_downsampling: chroma_downsampling, density_unit: density_unit, x_density: x_density, y_density: y_density, xmp_metadata: xmp_metadata)
      end

      def encode_png(image, compression: nil)
        RawOps.encode_png(image: image, compression: compression)
      end

      def extract_glimpse(input, size, offsets, centered: nil, normalized: nil, uniform_noise: nil, noise: nil)
        RawOps.extract_glimpse(input: input, size: size, offsets: offsets, centered: centered, normalized: normalized, uniform_noise: uniform_noise, noise: noise)
      end

      def extract_jpeg_shape(contents, output_type: nil)
        RawOps.extract_jpeg_shape(contents: contents, output_type: output_type)
      end

      # def extract_patches
      # end

      # def flip_left_right
      # end

      # def flip_up_down
      # end

      # def grayscale_to_rgb
      # end

      def hsv_to_rgb(images)
        RawOps.hsv_to_rgb(images: images)
      end

      # def image_gradients
      # end

      # def is_jpeg
      # end

      def non_max_suppression(boxes, scores, max_output_size, iou_threshold: nil)
        RawOps.non_max_suppression(boxes: boxes, scores: scores, max_output_size: max_output_size, iou_threshold: iou_threshold)
      end

      # def non_max_suppression_overlaps
      # end

      # def non_max_suppression_padded
      # end

      # def non_max_suppression_with_scores
      # end

      # def pad_to_bounding_box
      # end

      # def per_image_standardization
      # end

      # def psnr
      # end

      # def random_brightness
      # end

      # def random_contrast
      # end

      def random_crop(image, size, seed: nil, seed2: nil)
        RawOps.random_crop(image: image, size: size, seed: seed, seed2: seed2)
      end

      # def random_flip_left_right
      # end

      # def random_flip_up_down
      # end

      # def random_hue
      # end

      # def random_jpeg_quality
      # end

      # def random_saturation
      # end

      # def resize
      # end

      # def resize_with_crop_or_pad
      # end

      # def resize_with_pad
      # end

      # def rgb_to_grayscale
      # end

      def rgb_to_hsv(images)
        RawOps.rgb_to_hsv(images: images)
      end

      # def rgb_to_yiq
      # end

      # def rgb_to_yuv
      # end

      # def rot90
      # end

      def sample_distorted_bounding_box(image_size, bounding_boxes, seed: nil, seed2: nil, min_object_covered: nil, aspect_ratio_range: nil, area_range: nil, max_attempts: nil, use_image_if_no_bounding_boxes: nil)
        RawOps.sample_distorted_bounding_box(image_size: image_size, bounding_boxes: bounding_boxes, seed: seed, seed2: seed2, min_object_covered: min_object_covered, aspect_ratio_range: aspect_ratio_range, area_range: area_range, max_attempts: max_attempts, use_image_if_no_bounding_boxes: use_image_if_no_bounding_boxes)
      end

      # def sobel_edges
      # end

      # def ssim
      # end

      # def ssim_multiscale
      # end

      # def total_variation
      # end

      def transpose(x, perm)
        RawOps.transpose(x: x, perm: perm)
      end

      # def yiq_to_rgb
      # end

      # def yuv_to_rgb
      # end
    end
  end
end