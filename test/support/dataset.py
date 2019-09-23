import tensorflow as tf

mnist = tf.keras.datasets.mnist
(x_train, y_train), (x_test, y_test) = mnist.load_data()

train_ds = tf.data.Dataset.from_tensor_slices((x_train, y_train)).shuffle(10000).batch(32)

i = 0
for images, labels in train_ds:
  print("train_ds:", i, images.shape, labels.shape)
  i += 1
