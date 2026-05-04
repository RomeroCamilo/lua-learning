#!/bin/bash
# Compile mathlib.cpp into a shared library that Lua can load.
#
# macOS-specific flags:
#   -bundle                 build a loadable bundle (not a .dylib)
#   -undefined dynamic_lookup   resolve Lua symbols at load time
#                              (the host Lua interpreter provides them)
set -e
g++ -std=c++17 -Wall -O2 -bundle -undefined dynamic_lookup \
    $(pkg-config --cflags lua) mathlib.cpp -o mathlib.so
echo "Built ./mathlib.so"
