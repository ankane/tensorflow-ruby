# TensorFlow

:fire: [TensorFlow](https://github.com/tensorflow/tensorflow) - the end-to-end machine learning platform - for Ruby

This gem is currently experimental and only supports basic tensor operations at the moment. Check out [Torch-rb](https://github.com/ankane/torch-rb) for a more complete deep learning library.

[![Build Status](https://travis-ci.org/ankane/tensorflow.svg?branch=master)](https://travis-ci.org/ankane/tensorflow)

## Installation

[Install TensorFlow](#tensorflow-installation). For Homebrew, use:

```sh
brew install tensorflow
```

Add this line to your application’s Gemfile:

```ruby
gem 'tensorflow'
```

## Getting Started

This library follows the TensorFlow 2 [Python API](https://www.tensorflow.org/versions/r2.0/api_docs/python/tf). Many methods and options are missing at the moment. Here’s the [current plan](https://github.com/ankane/tensorflow/issues/1). Additional PRs welcome!

## Constants

```ruby
a = Tf.constant([1, 2, 3])
b = Tf.constant([4, 5, 6])
a + b
```

## Variables

```ruby
v = Tf::Variable.new(0.0)
w = v + 1
```

## Math

```ruby
Tf::Math.abs([-1, -2])
Tf::Math.sqrt([1.0, 4.0, 9.0])
```

## FizzBuzz

```ruby
def fizzbuzz(max_num)
  max_num.times do |i|
    num = Tf.constant(i + 1)
    if (num % 3).to_i == 0 && (num % 5).to_i == 0
      puts "FizzBuzz"
    elsif (num % 3).to_i == 0
      puts "Fizz"
    elsif (num % 5).to_i == 0
      puts "Buzz"
    else
      puts num.to_i
    end
  end
end

fizzbuzz(15)
```

## Data::Dataset

```ruby
# load
train_dataset = Tf::Data::Dataset.from_tensor_slices([train_examples, train_labels])
test_dataset = Tf::Data::Dataset.from_tensor_slices([test_examples, test_labels])

# shuffle and batch
train_dataset = train_dataset.shuffle(100).batch(32)
test_dataset = test_dataset.batch(32)

# iterate
train_dataset.each do |examples, labels|
  # ...
end
```

## Keras [coming soon]

```ruby
mnist = Tf::Keras::Datasets::MNIST
(x_train, y_train), (x_test, y_test) = mnist.load_data
x_train = x_train / 255.0
x_test = x_test / 255.0

model = Tf::Keras::Models::Sequential.new([
  Tf::Keras::Layers::Flatten.new(input_shape: [28, 28]),
  Tf::Keras::Layers::Dense.new(128, activation: "relu"),
  Tf::Keras::Layers::Dropout.new(0.2),
  Tf::Keras::Layers::Dense.new(10, activation: "softmax")
])

model.compile(optimizer: "adam", loss: "sparse_categorical_crossentropy", metrics: ["accuracy"])
model.fit(x_train, y_train, epochs: 5)
model.evaluate(x_test, y_test)
```

## TensorFlow Installation

### Mac

Run:

```sh
brew install tensorflow
```

Alternatively, download the [shared library](https://www.tensorflow.org/install/lang_c#download) and move the files in `lib` to `/usr/local/lib`.

### Linux

Download the [shared library](https://www.tensorflow.org/install/lang_c#download) and move the files in `lib` to `/usr/local/lib`.

### Windows

Download the [shared library](https://www.tensorflow.org/install/lang_c#download) and move `tensorflow.dll` to `C:\Windows\System32`.

## History

View the [changelog](https://github.com/ankane/tensorflow/blob/master/CHANGELOG.md)

## Contributing

Everyone is encouraged to help improve this project. Here are a few ways you can help:

- [Report bugs](https://github.com/ankane/tensorflow/issues)
- Fix bugs and [submit pull requests](https://github.com/ankane/tensorflow/pulls)
- Write, clarify, or fix documentation
- Suggest or add new features

To get started with development and testing:

```sh
git clone https://github.com/ankane/tensorflow.git
cd tensorflow
bundle install
rake test
```
