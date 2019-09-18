#!/usr/bin/env bash

set -e

CACHE_DIR=$HOME/tensorflow/$TENSORFLOW_VERSION

if [ ! -d "$CACHE_DIR" ]; then
  wget https://storage.googleapis.com/tensorflow/libtensorflow/libtensorflow-cpu-linux-x86_64-$TENSORFLOW_VERSION.tar.gz
  tar xvfz libtensorflow-cpu-linux-x86_64-$TENSORFLOW_VERSION.tar.gz --one-top-level
  mv libtensorflow-cpu-linux-x86_64-$TENSORFLOW_VERSION $CACHE_DIR
else
  echo "TensorFlow cached"
fi
