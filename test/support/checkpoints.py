import tensorflow as tf

x = tf.Variable(10.)
checkpoint = tf.train.Checkpoint(x=x)

x.assign(2.)

checkpoint_path = '/tmp/ckpt/'
checkpoint.save(checkpoint_path)

x.assign(11.)

checkpoint.restore(tf.train.latest_checkpoint(checkpoint_path))

print(x)
