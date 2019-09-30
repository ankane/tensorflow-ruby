import tensorflow as tf

# x = tf.constant(3.0)
# with tf.GradientTape() as g:
#   g.watch(x)
#   y = x * x
# dy_dx = g.gradient(y, x)
# print(dy_dx)

# @tf.function
def test_func(x):
  return x*x

theoretical, numerical = tf.test.compute_gradient(test_func, [3.0])
print(theoretical)
print(numerical)
