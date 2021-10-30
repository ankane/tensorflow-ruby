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

  Rice::define_module_under(m, "Tape")
    .define_singleton_function(
      "push_new_tape",
      [](bool persistent, bool watch_accessed_variables) {
        // TODO TFE_Py_TapeSetNew
      })
    .define_singleton_function(
      "push_tape",
      [](Rice::Object tape) {
        // TODO TFE_Py_TapeSetAdd
      })
    .define_singleton_function(
      "pop_tape",
      [](Rice::Object tape) {
        // TODO TFE_Py_TapeSetRemove
      })
    .define_singleton_function(
      "watch",
      [](Rice::Object tape, Rice::Object tensor) {
        // TODO TFE_Py_TapeWatch
      })
    .define_singleton_function(
      "gradient",
      [](Rice::Object tape, Rice::Object target, Rice::Object sources) {
        // TODO TFE_Py_TapeGradient
      });
}
