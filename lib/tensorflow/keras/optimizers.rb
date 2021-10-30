module TensorFlow
  module Keras
    module Optimizers
      class << self
        def get(identifier)
          case identifier
          when "adam"
            Adam.new
          else
            raise Error, "Could not interpret optimizer identifier: #{identifier}"
          end
        end
      end
    end
  end
end
