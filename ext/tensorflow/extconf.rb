require "mkmf-rice"

$CXXFLAGS += " -std=c++17 $(optflags)"

inc, lib = dir_config("tensorflow")
inc ||= "/usr/local/include"
lib ||= "/usr/local/lib"

abort "TensorFlow not found" unless find_library("tensorflow", nil, lib)

# TODO find_header

create_makefile("tensorflow/ext")
