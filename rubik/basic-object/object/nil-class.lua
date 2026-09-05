-- NilClass
-- ---------------------------------------------------------------------

local class = require("middleclass")

local Object = require("rubik.basic-object.object")

-- ---------------------------------------------------------------------

local NilClass = class("NilClass", Object)

-- ---------------------------------------------------------------------
-- Class
-- ---------------------------------------------------------------------

-- NilClass::new (Rubik Only)
-- ---------------------------------------------------------------------

function NilClass:initialize()
  self.__lua = nil
end

-- NilClass::fromLiteral

function NilClass.static.fromLiteral()
  return NilClass:new()
end

-- ---------------------------------------------------------------------
-- Super
-- ---------------------------------------------------------------------

-- NilClass#derubik
-- ---------------------------------------------------------------------

function NilClass:derubik()
  return self.__lua
end

-- ---------------------------------------------------------------------
-- Instance
-- ---------------------------------------------------------------------

-- NilClass#to_a
-- ---------------------------------------------------------------------

function NilClass:to_a()
  return NilClass.rubik("Array", {})
end

-- NilClass#to_f
-- ---------------------------------------------------------------------

function NilClass:to_f()
  return NilClass.rubik("Float", 0)
end

-- NilClass#to_i
-- ---------------------------------------------------------------------

function NilClass:to_i()
  return NilClass.rubik("Integer", 0)
end

-- NilClass#to_s
-- ---------------------------------------------------------------------

function NilClass:to_s()
  return NilClass.rubik("String", "")
end

-- ---------------------------------------------------------------------

return NilClass
