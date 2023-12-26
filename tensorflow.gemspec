require_relative "lib/tensorflow/version"

Gem::Specification.new do |spec|
  spec.name          = "tensorflow"
  spec.version       = TensorFlow::VERSION
  spec.summary       = "TensorFlow - the end-to-end machine learning platform - for Ruby"
  spec.homepage      = "https://github.com/ankane/tensorflow-ruby"
  spec.license       = "Apache-2.0"

  spec.author        = "Andrew Kane"
  spec.email         = "andrew@ankane.org"

  spec.files         = Dir["*.{md,txt}", "{lib}/**/*"]
  spec.require_path  = "lib"

  spec.required_ruby_version = ">= 2.6"

  spec.add_dependency "ffi"
  spec.add_dependency "numo-narray"
  spec.add_dependency "npy"
  spec.add_dependency "base64"
end
