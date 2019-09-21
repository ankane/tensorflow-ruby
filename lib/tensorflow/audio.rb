module TensorFlow
  module Audio
    class << self
      def decode_wav(contents, desired_channels: nil, desired_samples: nil)
        RawOps.decode_wav(contents: contents, desired_channels: desired_channels, desired_samples: desired_samples)
      end

      def encode_wav(audio, sample_rate)
        RawOps.encode_wav(audio: audio, sample_rate: sample_rate)
      end
    end
  end
end