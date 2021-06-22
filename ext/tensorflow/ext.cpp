#include <tensorflow/core/public/version.h>

#include <rice/rice.hpp>

extern "C"
void Init_ext()
{
  auto m = Rice::define_module("TensorFlow");
  m.define_singleton_function(
    "library_version",
    []() {
      return Rice::String(TF_VERSION_STRING);
    });
}
