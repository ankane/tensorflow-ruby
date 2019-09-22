import tensorflow as tf

print("boston_housing")
boston_housing = tf.keras.datasets.boston_housing
(x_train, y_train),(x_test, y_test) = boston_housing.load_data()
print(x_train.shape, y_train.shape, x_test.shape, y_test.shape)

print("mnist")
mnist = tf.keras.datasets.mnist
(x_train, y_train),(x_test, y_test) = mnist.load_data()
print(x_train.shape, y_train.shape, x_test.shape, y_test.shape)
