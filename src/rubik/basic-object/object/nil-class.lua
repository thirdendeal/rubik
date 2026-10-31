-- NilClass
-- -----------------------------------------------------------------------------

local class = require("middleclass")

local Object = require(CWD .. "rubik.basic-object.object")

-- -----------------------------------------------------------------------------

local NilClass = class("NilClass", Object)

-- -----------------------------------------------------------------------------
-- Public Class Methods
-- -----------------------------------------------------------------------------

-- NilClass::new
-- -----------------------------------------------------------------------------

function NilClass:initialize()
  Object.initialize(self, nil)
end

-- -----------------------------------------------------------------------------
-- Public Instance Methods
-- -----------------------------------------------------------------------------

-- NilClass#derubik
-- -----------------------------------------------------------------------------

function NilClass:derubik()
  return self.__literal
end

-- NilClass#to_a
-- -----------------------------------------------------------------------------

function NilClass:to_a()
  return NilClass.rubik("Array", {})
end

-- NilClass#to_f
-- -----------------------------------------------------------------------------

function NilClass:to_f()
  return NilClass.rubik("Float", 0)
end

-- NilClass#to_i
-- -----------------------------------------------------------------------------

function NilClass:to_i()
  return NilClass.rubik("Integer", 0)
end

-- NilClass#to_s
-- -----------------------------------------------------------------------------

function NilClass:to_s()
  return NilClass.rubik("String", "")
end

-- NilClass#to_h
-- -----------------------------------------------------------------------------

function NilClass:to_h()
  return NilClass.rubik("Hash", {})
end

-- -----------------------------------------------------------------------------

return NilClass
