-- 1. Printing
print("Hello, Lua!")

-- 2. Variables (no type declarations needed)
local name = "Camilo"
local age = 25
local is_learning = true

print("Name:", name, "Age:", age)

-- 3. Strings
local greeting = "Hello, " .. name .. "!"  -- .. concatenates strings
print(greeting)
print("Length of name:", #name)            -- # gets length

-- 4. If / elseif / else
if age < 18 then
    print("Minor")
elseif age < 65 then
    print("Adult")
else
    print("Senior")
end

-- 5. Loops
for i = 1, 5 do
    print("Count:", i)
end

local n = 3
while n > 0 do
    print("Countdown:", n)
    n = n - 1
end

-- 6. Functions
local function add(a, b)
    return a + b
end

print("2 + 3 =", add(2, 3))

-- Functions can return multiple values
local function min_max(a, b)
    if a < b then return a, b else return b, a end
end

local lo, hi = min_max(10, 4)
print("min:", lo, "max:", hi)

-- 7. Tables (Lua's only data structure — acts as array AND dictionary)
local fruits = {"apple", "banana", "cherry"}     -- array-style (1-indexed!)
print("First fruit:", fruits[1])

for i, fruit in ipairs(fruits) do
    print(i, fruit)
end

local person = {name = "Ana", age = 30}          -- dictionary-style
print(person.name, "is", person.age)

for key, value in pairs(person) do
    print(key, "=", value)
end

-- 8. nil represents "no value"
local nothing = nil
print("nothing is:", nothing)
