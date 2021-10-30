module TensorFlow
  module Keras
    module Optimizers
      class OptimizerV2
        def initialize(name, **kwargs)
          @name = name
          @hyper = {}
          decay = kwargs.delete("decay") { 0.0 }
          if decay < 0
            raise ArgumentError, "decay cannot be less than 0: #{decay}"
          end
          @initial_decay = decay
        end

        protected

        def set_hyper(name, value)
          @hyper[name] = value
        end
      end
    end
  end
end
