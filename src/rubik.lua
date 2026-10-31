-- Rubik
-- -----------------------------------------------------------------------------

-- CWD Workaround
-- -----------------------------------------------------------------------------
--
-- Lua's `require` makes callers need to share this file's directory
--   local rubik = require("rubik")
--
-- Now callers can also be placed elsewhere
--   local rubik = require("rubik")
--   local rubik = require("libraries.thirdendeal.rubik")

CWD               = (...):gsub("rubik$", "") .. "." -- current working directory

-- -----------------------------------------------------------------------------

local BasicObject = require(CWD .. "rubik.basic-object")

local Object      = require(CWD .. "rubik.basic-object.object")

local Array       = require(CWD .. "rubik.basic-object.object.array")
local Enumerator  = require(CWD .. "rubik.basic-object.object.enumerator")
local FalseClass  = require(CWD .. "rubik.basic-object.object.false-class")
local Hash        = require(CWD .. "rubik.basic-object.object.hash")
local NilClass    = require(CWD .. "rubik.basic-object.object.nil-class")
local Numeric     = require(CWD .. "rubik.basic-object.object.numeric")
local String      = require(CWD .. "rubik.basic-object.object.string")
local TrueClass   = require(CWD .. "rubik.basic-object.object.true-class")

local Float       = require(CWD .. "rubik.basic-object.object.numeric.float")
local Integer     = require(CWD .. "rubik.basic-object.object.numeric.integer")

-- -----------------------------------------------------------------------------

local rubik       = { _version = "0.0.0" }
local metatable   = {}

-- Rubik::fromLiteral
-- -----------------------------------------------------------------------------

-- rubik.fromLiteral(value)
-- rubik.fromLiteral(className, value)

function rubik.fromLiteral(...)
  if #arg == 2 then                  -- rubik("Array", {})
    return rubik[arg[1]]:new(arg[2]) -- Array:new({})
  end

  local literal = arg[1]

  if rubik["already?"](literal) then
    return literal
  end

  local literalType = type(literal)

  -- TODO: Define optimal checking order

  if literalType == "boolean" then
    if literal then
      return TrueClass:new()
    else
      return FalseClass:new()
    end
  elseif literalType == "nil" then
    return NilClass:new()
  elseif literalType == "table" then
    local hasData = false
    for _, _ in pairs(literal) do
      hasData = true
      break
    end

    if hasData and (#literal == 0) then -- pure Hash
      return Hash:new(literal)
    else
      return Array:new(literal)
    end
  elseif literalType == "number" then
    local _, decimalPart = math.modf(literal)

    if decimalPart == 0 then
      return Integer:new(literal)
    else
      return Float:new(literal)
    end
  elseif literalType == "string" then
    return String:new(literal)
  else
    return BasicObject:new(literal)
  end
end

-- Rubik::__call metamethod

-- rubik(value)
-- rubik(class, value)

metatable.__call = function(_, ...)
  return rubik.fromLiteral(...)
end

-- Rubik::in_and_out
-- -----------------------------------------------------------------------------

function rubik.in_and_out(literal, method, ...)
  local object = rubik.fromLiteral(literal)

  return object[method](object, ...):derubik()
end

-- Rubik::__index metamethod

metatable.__index = function(_, index)
  return function(value, ...)
    return rubik.in_and_out(value, index, ...)
  end
end

-- Rubik::["<=>"]
-- -----------------------------------------------------------------------------

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
-- -----------------------------------------------------------------------------

function rubik.patch_quote_methods(object, methods)
  for _, method in ipairs(methods) do
    object[":" .. method] = function(...) -- monkey patch
      return object[method](object, ...)
    end
  end
end

-- Rubik::already?
-- -----------------------------------------------------------------------------

rubik["already?"] = function(value)
  local middleclass = type(value) == "table" and value.class and value.class.isSubclassOf

  return not not (middleclass and value.class:isSubclassOf(BasicObject)) -- true or false
end

-- Class Injection
-- -----------------------------------------------------------------------------

rubik.BasicObject = BasicObject

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

-- -----------------------------------------------------------------------------

BasicObject.static.rubik = rubik

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
-- -----------------------------------------------------------------------------

local digits, _ = string.gsub(tostring(os.clock()), "%.", "")

math.randomseed(tonumber(digits))
math.randomseed(math.random(os.time()))

-- -----------------------------------------------------------------------------

setmetatable(rubik, metatable)

return rubik
