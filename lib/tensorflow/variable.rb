module TensorFlow
  class Variable
    def initialize(initial_value, dtype: nil)
      @dtype = dtype || Utils.infer_type(Array(initial_value).flatten)
      @pointer = RawOps.var_handle_op(dtype: type_enum, shape: [], shared_name: Utils.default_context.shared_name)
      assign(initial_value)
    end

    def assign(value)
      value = TensorFlow.convert_to_tensor(value, dtype: @dtype)
      RawOps.assign_variable_op(resource: @pointer, value: value)
      self
    end

    def assign_add(value)
      value = TensorFlow.convert_to_tensor(value, dtype: @dtype)
      RawOps.assign_add_variable_op(resource: @pointer, value: value)
      self
    end

    def assign_sub(value)
      value = TensorFlow.convert_to_tensor(value, dtype: @dtype)
      RawOps.assign_sub_variable_op(resource: @pointer, value: value)
      self
    end

    def read_value
      RawOps.read_variable_op(resource: @pointer, dtype: type_enum)
    end

    def +(other)
      v = Variable.new(read_value.value, dtype: @dtype)
      v.assign_add(other).read_value
    end

    def -(other)
      v = Variable.new(read_value.value, dtype: @dtype)
      v.assign_sub(other).read_value
    end

    def to_s
      inspect
    end

    def inspect
      value = read_value
      inspection = %w(value shape dtype).map { |v| "#{v}: #{value.send(v).inspect}"}
      "#<#{self.class} #{inspection.join(", ")}>"
    end

    private

    def type_enum
      FFI::DataType[@dtype.to_sym] if @dtype
    end
  end
end
