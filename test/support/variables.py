# set TF_CPP_MIN_VLOG_LEVEL=3 to debug
import tensorflow as tf

v = tf.Variable(0.0)
w = v + 1
print(v)
print(w)
