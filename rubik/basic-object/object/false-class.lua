-- FalseClass
-- ---------------------------------------------------------------------

local class = require("middleclass")

local Object = require("rubik.basic-object.object")

-- ---------------------------------------------------------------------

local FalseClass = class("FalseClass", Object)

-- ---------------------------------------------------------------------
-- Class
-- ---------------------------------------------------------------------

-- FalseClass::new (Rubik Only)
-- ---------------------------------------------------------------------

function FalseClass:initialize()
  self.__lua = false
end

-- FalseClass::fromLiteral

function FalseClass.static.fromLiteral()
  return FalseClass:new()
end

-- ---------------------------------------------------------------------
-- Instance
-- ---------------------------------------------------------------------

-- FalseClass#derubik
-- ---------------------------------------------------------------------

function FalseClass:derubik()
  return self.__lua
end

-- ---------------------------------------------------------------------

return FalseClass
