-- Rubik
-- ---------------------------------------------------------------------

local Object = require("rubik.object")

local Array = require("rubik.array")
local Enumerator = require("rubik.enumerator")
local Integer = require("rubik.integer")
local Kernel = require("rubik.kernel")

-- ---------------------------------------------------------------------

local rubik = { _version = "0.0.0" }
local metatable = {}

-- Wrap
-- ---------------------------------------------------------------------

function rubik.wrap(recipe)
  local recipeType = type(recipe)

  if recipeType == "table" then
    if recipe.__recipe then
      recipe = recipe.__recipe
    end

    return Array.wrap(recipe)
  elseif recipeType == "number" then
    return Integer.wrap(recipe) -- float disambiguation later
  else
    return Object.wrap(recipe)
  end
end

-- rubik(recipe)

metatable.__call = function(_, ...)
  return rubik.wrap(...)
end

-- Wrap, Forward and Unwrap
-- ---------------------------------------------------------------------

function rubik.inAndOut(recipe, method, ...)
  local object = rubik.wrap(recipe)

  return object[method](object, ...):unwrap()
end

-- rubik.method(recipe, ...)

metatable.__index = function(_, index)
  return function(recipe, ...)
    return rubik.inAndOut(recipe, index, ...)
  end
end

-- Ruby
-- ---------------------------------------------------------------------

-- Three-Way Comparison

rubik["<=>"] = function(a, b)
  if a > b then
    return 1
  elseif a == b then
    return 0
  else
    return -1
  end
end

-- Monkey Patch
-- ---------------------------------------------------------------------

function rubik.patchQuoteMethods(object, methods)
  for _, method in ipairs(methods) do
    object[":" .. method] = function(...)
      return object[method](object, ...)
    end
  end
end

-- Class Injection
-- ---------------------------------------------------------------------

rubik.Object = Object

rubik.Array = Array
rubik.Enumerator = Enumerator
rubik.Integer = Integer
rubik.Kernel = Kernel

-- ---------------------------------------------------------------------

Object.static.rubik = rubik

Array.static.rubik = rubik
Enumerator.static.rubik = rubik
Integer.static.rubik = rubik
Kernel.static.rubik = rubik

-- Pseudo-Randomness
-- ---------------------------------------------------------------------

local digits, _ = string.gsub(tostring(os.clock()), "%.", "")

math.randomseed(tonumber(digits))
math.randomseed(math.random(os.time()))

-- ---------------------------------------------------------------------

setmetatable(rubik, metatable)

return rubik
