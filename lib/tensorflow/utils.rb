module Tensorflow
  module Utils
    NUMO_TYPE_MAP = {
      int8: Numo::Int8,
      int16: Numo::Int16,
      int32: Numo::Int32,
      int64: Numo::Int64,
      uint8: Numo::UInt8,
      uint16: Numo::UInt16,
      uint32: Numo::UInt32,
      uint64: Numo::UInt64,
      float: Numo::SFloat,
      double: Numo::DFloat
    }

    class << self
      def infer_type(value)
        if value.is_a?(Numo::NArray)
          type = NUMO_TYPE_MAP.find { |k, v| value.is_a?(v) }
          if type
            type.first
          else
            raise Error, "Unable to infer data type"
          end
        elsif value.empty?
          raise Error, "Unable to infer data type"
        elsif value.all? { |v| v.is_a?(String) }
          :string
        elsif value.all? { |v| v.is_a?(TrueClass) || v.is_a?(FalseClass) }
          :bool
        elsif value.all? { |v| v.is_a?(Integer) }
          if value.all? { |v| v >= -2147483648 && v <= 2147483647 }
            :int32
          else
            :int64
          end
        elsif value.all? { |v| v.is_a?(Complex) }
          :complex128
        elsif value.all? { |v| v.is_a?(Numeric) }
          :float
        else
          raise Error, "Unable to infer data type"
        end
      end

      def to_tensor_array(values)
        case values
          when Numo::NArray
            [Tensor.new(values)]
          when Tensor
            [values]
          else
            values.to_a.map do |v|
              if v.is_a?(Tensor)
                v
              else
                Tensorflow.convert_to_tensor(v)
              end
            end
        end
      end
    end
  end
end
