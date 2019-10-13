module Tensorflow
  class Variable
    attr_reader :name

    def initialize(initial_value = nil, dtype: nil, shape: nil, name: nil)
      @dtype = dtype || Utils.infer_type(Array(initial_value).flatten)
      @shape = shape
      @name = name
      @pointer = RawOps.var_handle_op(dtype: type_enum, shape: [], shared_name: Context.default.shared_name)
      assign(initial_value) if initial_value
    end

    def assign(value)
      value = Tensorflow.convert_to_tensor(value, dtype: @dtype)
      RawOps.assign_variable_op(resource: @pointer, value: value)
      self
    end

    def assign_add(value)
      value = Tensorflow.convert_to_tensor(value, dtype: @dtype)
      RawOps.assign_add_variable_op(resource: @pointer, value: value)
      self
    end

    def assign_sub(value)
      value = Tensorflow.convert_to_tensor(value, dtype: @dtype)
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

    def shape
      read_value.shape
    end

    def inspect
      value = read_value
      inspection = %w(numo shape dtype).map { |v| "#{v}: #{value.send(v).inspect}"}
      inspection.unshift("name: #{name}") if name
      "#<#{self.class} #{inspection.join(", ")}>"
    end

    def to_ptr
      read_value.to_ptr
    end

    private

    def type_enum
      FFI::DataType[@dtype.to_sym] if @dtype
    end
  end
end
