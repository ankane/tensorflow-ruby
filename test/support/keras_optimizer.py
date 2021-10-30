import tensorflow as tf

opt = tf.keras.optimizers.Adam(learning_rate=0.1)
var1 = tf.Variable(10.0)
print(var1.__class__)
print((var1 ** 2).__class__)
loss = lambda: (var1 ** 2) / 2.0
step_count = opt.minimize(loss, [var1]).numpy()
print(var1.numpy())
