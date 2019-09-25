require_relative "test_helper"

class KerasTest < Minitest::Test
  def test_sequential
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

    skip

    model.compile(optimizer: "adam", loss: "sparse_categorical_crossentropy", metrics: ["accuracy"])

    model.fit(x_train, y_train, epochs: 5)
    model.evaluate(x_test, y_test)
  end

  def test_subclassing
    mnist = Tf::Keras::Datasets::MNIST
    (x_train, y_train), (x_test, y_test) = mnist.load_data
    x_train = x_train / 255.0
    x_test = x_test / 255.0

    x_train = x_train.expand_dims(3)
    x_test = x_test.expand_dims(3)

    train_ds = Tf::Data::Dataset.from_tensor_slices([x_train, y_train]).batch(32)
    test_ds = Tf::Data::Dataset.from_tensor_slices([x_test, y_test]).batch(32)

    # Create an instance of the model
    model = MyModel.new

    loss_object = Tf::Keras::Losses::SparseCategoricalCrossentropy.new
    optimizer = Tf::Keras::Optimizers::Adam.new

    train_loss = Tf::Keras::Metrics::Mean.new(name: "train_loss")
    train_accuracy = Tf::Keras::Metrics::SparseCategoricalAccuracy.new(name: "train_accuracy")

    test_loss = Tf::Keras::Metrics::Mean.new(name: "test_loss")
    test_accuracy = Tf::Keras::Metrics::SparseCategoricalAccuracy.new(name: "test_accuracy")

    train_step = lambda do |images, labels|
      predictions = nil
      loss = nil
      tape = Tf::GradientTape.new do
        predictions = model.call(images)
        loss = loss_object.call(labels, predictions)
      end
      # p tape
      # p model.trainable_variables
      gradients = tape.gradient(loss, model.trainable_variables)
      optimizer.apply_gradients(gradients.zip(model.trainable_variables))

      abort "done"

      train_loss.call(loss)
      train_accuracy.call(labels, predictions)
    end

    test_step = lambda do |images, labels|
      predictions = model.call(images)
      t_loss = loss_object.call(labels, predictions)

      test_loss.call(t_loss)
      test_accuracy.call(labels, predictions)
    end

    epochs = 1
    epochs.times do |epoch|
      train_ds.each do |images, labels|
        train_step.call(images, labels)
      end

      test_ds.each do |test_images, test_labels|
        test_step.call(test_images, test_labels)
      end

      train_loss.reset_states
      train_accuracy.reset_states
      test_loss.reset_states
      test_accuracy.reset_states
    end
  end

  def test_metrics_mean
    m = Tf::Keras::Metrics::Mean.new
    m.update_state([1, 3, 5, 7])
    assert_equal 4, m.result.value
  end

  def test_metrics_sparse_categorical_accuracy
    m = Tf::Keras::Metrics::SparseCategoricalAccuracy.new
    m.update_state([[2], [1]], [[0.1, 0.9, 0.8], [0.05, 0.95, 0]])
    assert_in_delta 0.5, m.result.value
  end

  def test_get_file
    csv_file = Tf::Keras::Utils.get_file("heart.csv", "https://storage.googleapis.com/applied-dl/heart.csv")
    assert_equal "heart.csv", csv_file.split("/").last
  end
end
