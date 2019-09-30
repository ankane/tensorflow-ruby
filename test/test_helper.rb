require "bundler/setup"
Bundler.require(:default)
require "minitest/autorun"
require "minitest/pride"
require "base64"
require "mini_magick"

class Minitest::Test
  private

  def teardown
    @tempfile = nil
  end

  def tempfile
    @tempfile ||= "#{tempdir}/#{Time.now.to_f}"
  end

  def tempdir
    @tempdir ||= File.dirname(Tempfile.new("tensorflow"))
  end
end

class MyModel < Tf::Keras::Model
  def initialize
    super
    @flatten = Tf::Keras::Layers::Flatten.new(input_shape: [28, 28])
    @d1 = Tf::Keras::Layers::Dense.new(128, activation: "relu")
    @dropout = Tf::Keras::Layers::Dropout.new(0.2)
    @d2 = Tf::Keras::Layers::Dense.new(10, activation: "softmax")
  end

  def call(x)
    x = @flatten.call(x)
    x = @d1.call(x)
    x = @dropout.call(x)
    @d2.call(x)
  end
end
