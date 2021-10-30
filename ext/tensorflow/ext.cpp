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
        return Rice::Nil;
      })
    .define_singleton_function(
      "pop_tape",
      [](Rice::Object tape) {
        // TODO
      });
}
