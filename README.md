# qlass

Simple classes for Lua

## Usage

simple class

```lua
local class = require "class"

local Person = class "Person"

function Person:init(name, age)
  self.name = name
  self.age = age
end

function Person:introduce()
  print(
    ("Hello, my name is %s and I'm %d years old")
    :format(self.name, self.age)
  )
end

local jason = Person("Jason", 100)
jason:introduce()
```

inheritance and abstract classes

```lua
local class = require "class"

local Animal = class:abstract "Animal"

function Animal:init()
end

local Dog = Animal "Dog" -- Dog is not abstract

function Dog:bark()
  print "bark"
end
```

metamethods

```lua
local class = require "class"

local A = class "A"

function A:__call(n)
  print(self * n)
end

function A:__mul(n)
  return ("A"):rep(n)
end

-- inheritance is still possible
local B = A:extend "B"
```
