module TensorFlow
  module Keras
    module Optimizers
      class Adam < OptimizerV2
        def initialize(learning_rate: 0.001, beta_1: 0.9, beta_2: 0.999, epsilon: 1e-7, amsgrad: false, name: "Adam", **kwargs)
          super(name, **kwargs)
          set_hyper("learning_rate", kwargs.fetch("lr", learning_rate))
          set_hyper("decay", @initial_decay)
          set_hyper("beta_1", beta_1)
          set_hyper("beta_2", beta_2)
          @epsilon = epsilon # || backend_config.epsilon()
          @amsgrad = amsgrad
        end
      end
    end
  end
end
