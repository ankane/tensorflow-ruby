import tensorflow as tf

print("boston_housing")
boston_housing = tf.keras.datasets.boston_housing
(x_train, y_train),(x_test, y_test) = boston_housing.load_data()
print(x_train.shape, y_train.shape, x_test.shape, y_test.shape)

# print("cifar10")
# cifar10 = tf.keras.datasets.cifar10
# (x_train, y_train),(x_test, y_test) = cifar10.load_data()
# print(x_train.shape, y_train.shape, x_test.shape, y_test.shape)

# print("cifar100")
# cifar100 = tf.keras.datasets.cifar100
# (x_train, y_train),(x_test, y_test) = cifar100.load_data()
# print(x_train.shape, y_train.shape, x_test.shape, y_test.shape)

print("fashion_mnist")
fashion_mnist = tf.keras.datasets.fashion_mnist
(x_train, y_train),(x_test, y_test) = fashion_mnist.load_data()
print(x_train.shape, y_train.shape, x_test.shape, y_test.shape)

print("imdb")
imdb = tf.keras.datasets.imdb
(x_train, y_train),(x_test, y_test) = imdb.load_data()
print(x_train.shape, y_train.shape, x_test.shape, y_test.shape)

print("mnist")
mnist = tf.keras.datasets.mnist
(x_train, y_train),(x_test, y_test) = mnist.load_data()
print(x_train.shape, y_train.shape, x_test.shape, y_test.shape)

print("reuters")
reuters = tf.keras.datasets.reuters
(x_train, y_train),(x_test, y_test) = reuters.load_data()
print(x_train.shape, y_train.shape, x_test.shape, y_test.shape)
print(len(reuters.get_word_index()))
