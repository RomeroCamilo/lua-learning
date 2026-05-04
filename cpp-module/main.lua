-- main.lua — pure Lua program that loads our C++ library.

-- Tell Lua to also look in the current folder for .so files.
package.cpath = "./?.so;" .. package.cpath

-- Load the C++ library. This runs luaopen_mathlib() and gets back a table.
local mathlib = require("mathlib")

print("Calling C++ functions from Lua:")
print("  mathlib.add(10, 20)       = " .. mathlib.add(10, 20))
print("  mathlib.multiply(6, 7)    = " .. mathlib.multiply(6, 7))
print("  mathlib.greet('Camilo')   = " .. mathlib.greet("Camilo"))

-- Use it like any other Lua module
local total = 0
for i = 1, 5 do
    total = mathlib.add(total, i)
end
print("Sum of 1..5 (each step in C++) = " .. total)
