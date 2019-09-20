require "bundler/gem_tasks"
require "rake/testtask"

task default: :test
Rake::TestTask.new do |t|
  t.libs << "test"
  t.pattern = "test/**/*_test.rb"
  t.warning = false
end

task :generate_ops do
  require "tensorflow"

  # TODO pull these into project?
  path = "#{ENV["HOME"]}/forks/tensorflow"
  $:.push(path)
  require "tensorflow/core/framework/op_def_pb"

  buffer = TensorFlow::FFI.TF_GetAllOpList
  encoded = buffer[:data].read_bytes(buffer[:length])

  # based on ActiveSupport underscore
  def underscore(str)
    str.gsub(/([A-Z]+)([A-Z][a-z])/,'\1_\2').gsub(/([a-z\d])([A-Z])/,'\1_\2').downcase
  end

  defs = []
  Tensorflow::OpList.decode(encoded).op.sort_by(&:name).each do |op|
    input_names = op.input_arg.map(&:name)
    if op.name[0] != "_" && op.name[-2..-1] != "V2" && input_names.first == "x"
      defs << %!def #{underscore(op.name)}(#{input_names.join(", ")})
  execute("#{op.name}", [#{input_names.join(", ")}])
end!
    end
  end
  puts defs.join("\n\n")
end
