require_relative "test_helper"

class OperationTest < Minitest::Test
  def test_operations
    operations = Tensorflow::Operation.operations
    assert_kind_of(Hash, operations)
    assert(operations.keys.length > 1000)
  end

  def test_op_def
    op_def = Tensorflow::Operation.op_def('ZipDataset')
    refute_nil(op_def)
  end

  def test_number_attr
    op_def = Tensorflow::Operation.op_def('ZipDataset')
    arg_def = op_def.input_arg.first
    assert_equal('N', arg_def.number_attr)
    assert_empty(arg_def.type_list_attr)
  end

  def test_type_list_attr
    op_def = Tensorflow::Operation.op_def('TensorSliceDataset')
    arg_def = op_def.input_arg.first
    assert_empty(arg_def.number_attr)
    assert_equal('Toutput_types', arg_def.type_list_attr)
  end
end
