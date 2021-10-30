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

        def minimize(loss, var_list, grad_loss: nil, name: nil, tape: nil)
          grads_and_vars = compute_gradients(loss, var_list, grad_loss: grad_loss, tape: tape)
          apply_gradients(grads_and_vars, name: name)
        end

        protected

        def set_hyper(name, value)
          @hyper[name] = value
        end

        def compute_gradients(loss, var_list, grad_loss: nil, tape: nil)
          if !loss.respond_to?(:call) && tape.nil?
            raise ArgumentError, "`tape` is required when a `Tensor` loss is passed."
          end
          tape ||= GradientTape.new

          if loss.respond_to?(:call)
            tape.record do
              if !var_list.respond_to?(:call)
                tape.watch(var_list)
              end
              loss = loss.call
              if var_list.respond_to?(:call)
                var_list = var_list.call
              end
            end
          end

          loss = nil
          tape.record do
            loss = transform_loss(loss)
          end

          var_list = Util::Nest.flatten(var_list)
          # with ops.name_scope_v2(self._name + "/gradients"):
          grads_and_vars = get_gradients(tape, loss, var_list, grad_loss)

          # self._assert_valid_dtypes([
          #     v for g, v in grads_and_vars
          #     if g is not None and v.dtype != dtypes.resource
          # ])

          grads_and_vars
        end

        def transform_loss(loss)
          loss
        end

        def get_gradients(tape, loss, var_list, grad_loss)
          grads = tape.gradient(loss, var_list) #, grad_loss)
          grads.zip(var_list).to_a
        end
      end
    end
  end
end
