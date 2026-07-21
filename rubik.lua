-- Rubik
-- ---------------------------------------------------------------------

local BasicObject = require("rubik.basic-object")
local Kernel = require("rubik.kernel")

local Object = require("rubik.basic-object.object")

local Array = require("rubik.basic-object.object.array")
local Enumerator = require("rubik.basic-object.object.enumerator")
local Numeric = require("rubik.basic-object.object.numeric")
local String = require("rubik.basic-object.object.string")

local Float = require("rubik.basic-object.object.numeric.float")
local Integer = require("rubik.basic-object.object.numeric.integer")

-- ---------------------------------------------------------------------

local rubik = { _version = "0.0.0" }
local metatable = {}

-- Rubik::wrap
-- ---------------------------------------------------------------------

function rubik.wrap(recipe)
  local recipeType = type(recipe)

  if recipeType == "table" then
    if recipe.__recipe then
      recipe = recipe.__recipe
    end

    return Array.wrap(recipe)
  elseif recipeType == "number" then
    local _, fractionalPart = math.modf(recipe)

    if fractionalPart == 0 then
      return Integer.wrap(recipe)
    else
      return Float.wrap(recipe)
    end
  elseif recipeType == "string" then
    return String.wrap(recipe)
  else
    return Object.wrap(recipe)
  end
end

-- Rubik::__call metamethod
--
-- rubik(recipe)

metatable.__call = function(_, ...)
  return rubik.wrap(...)
end

-- Rubik::in_and_out
-- ---------------------------------------------------------------------

function rubik.in_and_out(recipe, method, ...)
  local object = rubik.wrap(recipe)

  return object[method](object, ...):unwrap()
end

-- Rubik::__index metamethod
--
-- rubik.method(recipe, ...)

metatable.__index = function(_, index)
  return function(recipe, ...)
    return rubik.in_and_out(recipe, index, ...)
  end
end

-- Rubik::["<=>"]
-- ---------------------------------------------------------------------

rubik["<=>"] = function(a, b)
  if a > b then -- three-way comparison
    return 1
  elseif a == b then
    return 0
  else
    return -1
  end
end

-- Rubik::patch_quote_methods
-- ---------------------------------------------------------------------

function rubik.patch_quote_methods(object, methods)
  for _, method in ipairs(methods) do
    object[":" .. method] = function(...) -- monkey patch
      return object[method](object, ...)
    end
  end
end

-- Class Injection
-- ---------------------------------------------------------------------

rubik.BasicObject = BasicObject
rubik.Kernel = Kernel

rubik.Object = Object

rubik.Array = Array
rubik.Enumerator = Enumerator
rubik.Numeric = Numeric
rubik.String = String

rubik.Float = Float
rubik.Integer = Integer

-- ---------------------------------------------------------------------

BasicObject.static.rubik = rubik
Kernel.static.rubik = rubik

Object.static.rubik = rubik

Array.static.rubik = rubik
Enumerator.static.rubik = rubik
Numeric.static.rubik = rubik
String.static.rubik = rubik

Float.static.rubik = rubik
Integer.static.rubik = rubik

-- Pseudo-Randomness
-- ---------------------------------------------------------------------

local digits, _ = string.gsub(tostring(os.clock()), "%.", "")

math.randomseed(tonumber(digits))
math.randomseed(math.random(os.time()))

-- ---------------------------------------------------------------------

setmetatable(rubik, metatable)

return rubik
