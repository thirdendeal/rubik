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

-- Rubik::fromLiteral
-- ---------------------------------------------------------------------

function rubik.fromLiteral(value)
  local valueType = type(value)

  if valueType == "table" then
    if value.__lua then
      value = value.__lua
    end

    return Array.fromLiteral(value)
  elseif valueType == "number" then
    local _, decimalPart = math.modf(value)

    if decimalPart == 0 then
      return Integer.fromLiteral(value)
    else
      return Float.fromLiteral(value)
    end
  elseif valueType == "string" then
    return String.fromLiteral(value)
  else
    return Object.fromLiteral(value)
  end
end

-- Rubik::__call metamethod

metatable.__call = function(_, ...)
  return rubik.fromLiteral(...)
end

-- Rubik::in_and_out
-- ---------------------------------------------------------------------

function rubik.in_and_out(value, method, ...)
  local object = rubik.fromLiteral(value)

  return object[method](object, ...):derubik()
end

-- Rubik::__index metamethod

metatable.__index = function(_, index)
  return function(value, ...)
    return rubik.in_and_out(value, index, ...)
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

-- Rubik::already?
-- ---------------------------------------------------------------------

rubik["already?"] = function(value)
  local middleclass = type(value) == "table" and value.class and value.class.isSubclassOf

  return not not (middleclass and value.class:isSubclassOf(BasicObject)) -- true or false
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
