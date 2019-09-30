# https://www.tensorflow.org/guide/saved_model
import tensorflow as tf
import numpy as np

file = tf.keras.utils.get_file(
    "grace_hopper.jpg",
    "https://storage.googleapis.com/download.tensorflow.org/example_images/grace_hopper.jpg")
img = tf.keras.preprocessing.image.load_img(file, target_size=[224, 224])
print(img)
x = tf.keras.preprocessing.image.img_to_array(img)
print(x)
print(x.dtype)

# import matplotlib.pyplot as plt

# plt.imshow(img)
# plt.show()

print(x.shape)
print(x[tf.newaxis,...].shape)

# x = tf.keras.applications.mobilenet.preprocess_input(
#     x[tf.newaxis,...])
# print(x.shape)

# labels_path = tf.keras.utils.get_file(
#     'ImageNetLabels.txt',
#     'https://storage.googleapis.com/download.tensorflow.org/data/ImageNetLabels.txt')
# imagenet_labels = np.array(open(labels_path).read().splitlines())
# # print(imagenet_labels)

# pretrained_model = tf.keras.applications.MobileNet()

# loaded = tf.saved_model.load("/tmp/mobilenet/1/")
# print(list(loaded.signatures.keys()))

# infer = loaded.signatures["serving_default"]
# print(infer.structured_outputs)

# labeling = infer(tf.constant(x))[pretrained_model.output_names[0]]
# decoded = imagenet_labels[np.argsort(labeling)[0,::-1][:5]+1]
# print("Result after saving and loading:\n", decoded)
