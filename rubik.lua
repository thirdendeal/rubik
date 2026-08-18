-- Rubik
-- ---------------------------------------------------------------------

local BasicObject = require("rubik.basic-object")
local Kernel = require("rubik.kernel")

local Object = require("rubik.basic-object.object")

local Array = require("rubik.basic-object.object.array")
local Enumerator = require("rubik.basic-object.object.enumerator")
local FalseClass = require("rubik.basic-object.object.false-class")
local Hash = require("rubik.basic-object.object.hash")
local NilClass = require("rubik.basic-object.object.nil-class")
local Numeric = require("rubik.basic-object.object.numeric")
local String = require("rubik.basic-object.object.string")
local TrueClass = require("rubik.basic-object.object.true-class")

local Float = require("rubik.basic-object.object.numeric.float")
local Integer = require("rubik.basic-object.object.numeric.integer")

-- ---------------------------------------------------------------------

local rubik = { _version = "0.0.0" }
local metatable = {}

-- Rubik::fromLiteral
-- ---------------------------------------------------------------------

function rubik.fromLiteral(value)
  if rubik["already?"](value) then
    return value
  end

  local valueType = type(value)

  -- TODO: Define optimal checking order

  if valueType == "boolean" then
    if value then
      return TrueClass.fromLiteral()
    else
      return FalseClass.fromLiteral()
    end
  elseif valueType == "nil" then
    return NilClass.fromLiteral()
  elseif valueType == "table" then
    local hasData = false
    for _, _ in pairs(value) do
      hasData = true
      break
    end

    if hasData and (#value == 0) then -- pure Hash
      return Hash.fromLiteral(value)
    else
      return Array.fromLiteral(value)
    end
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
    return BasicObject.fromLiteral(value)
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

-- Rubik::patch_quoted_methods
-- ---------------------------------------------------------------------

function rubik.patch_quoted_methods(object, methods)
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
rubik.FalseClass = FalseClass
rubik.Hash = Hash
rubik.NilClass = NilClass
rubik.Numeric = Numeric
rubik.String = String
rubik.TrueClass = TrueClass

rubik.Float = Float
rubik.Integer = Integer

-- ---------------------------------------------------------------------

BasicObject.static.rubik = rubik
Kernel.static.rubik = rubik

Object.static.rubik = rubik

Array.static.rubik = rubik
Enumerator.static.rubik = rubik
FalseClass.static.rubik = rubik
Hash.static.rubik = rubik
NilClass.static.rubik = rubik
Numeric.static.rubik = rubik
String.static.rubik = rubik
TrueClass.static.rubik = rubik

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
