require_relative "lib/tensorflow/version"

Gem::Specification.new do |spec|
  spec.name          = "tensorflow"
  spec.version       = TensorFlow::VERSION
  spec.summary       = "TensorFlow - the end-to-end machine learning platform - for Ruby"
  spec.homepage      = "https://github.com/ankane/tensorflow"
  spec.license       = "MIT"

  spec.author        = "Andrew Kane"
  spec.email         = "andrew@chartkick.com"

  spec.files         = Dir["*.{md,txt}", "{lib}/**/*"]
  spec.require_path  = "lib"

  spec.required_ruby_version = ">= 2.4"

  spec.add_dependency "ffi"
  spec.add_dependency "npy"

  spec.add_development_dependency "bundler"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "minitest", ">= 5"
  spec.add_development_dependency "google-protobuf"
end
