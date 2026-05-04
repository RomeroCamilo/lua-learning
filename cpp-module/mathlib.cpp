// mathlib.cpp — a C++ library that Lua can load and call.
//
// We compile this into mathlib.so (a shared library).
// Lua then does `require("mathlib")` to load it.
//
// Build: ./build.sh
// Run:   lua main.lua

#include <string>

extern "C" {
    #include <lua.h>
    #include <lauxlib.h>
}

// Each function callable from Lua has the signature:
//     int func(lua_State* L)
// Args come from the Lua stack; results are pushed back.

static int l_add(lua_State* L) {
    double a = luaL_checknumber(L, 1);
    double b = luaL_checknumber(L, 2);
    lua_pushnumber(L, a + b);
    return 1;
}

static int l_multiply(lua_State* L) {
    double a = luaL_checknumber(L, 1);
    double b = luaL_checknumber(L, 2);
    lua_pushnumber(L, a * b);
    return 1;
}

static int l_greet(lua_State* L) {
    const char* name = luaL_checkstring(L, 1);
    std::string msg = "Hello from C++, " + std::string(name) + "!";
    lua_pushstring(L, msg.c_str());
    return 1;
}

// Table mapping Lua names → C++ functions.
// The {NULL, NULL} entry marks the end of the list.
static const luaL_Reg mathlib_funcs[] = {
    {"add",      l_add},
    {"multiply", l_multiply},
    {"greet",    l_greet},
    {NULL, NULL}
};

// Lua looks for a function named luaopen_<modulename> when you
// call require("mathlib"). It must be `extern "C"` so the C++
// compiler doesn't mangle its name.
extern "C" int luaopen_mathlib(lua_State* L) {
    luaL_newlib(L, mathlib_funcs);  // create a table with our functions
    return 1;                        // return that table to Lua
}
