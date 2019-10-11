module Tensorflow
  module Bitwise
    class << self
      def bitwise_and(x, y)
        RawOps.bitwise_and(x: x, y: y)
      end

      def bitwise_or(x, y)
        RawOps.bitwise_or(x: x, y: y)
      end

      def bitwise_xor(x, y)
        RawOps.bitwise_xor(x: x, y: y)
      end

      def invert(x)
        RawOps.invert(x: x)
      end

      def left_shift(x, y)
        RawOps.left_shift(x: x, y: y)
      end

      def right_shift(x, y)
        RawOps.right_shift(x: x, y: y)
      end
    end
  end
end
