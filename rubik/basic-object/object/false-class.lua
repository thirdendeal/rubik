-- FalseClass
-- ---------------------------------------------------------------------

local class = require("middleclass")

local Object = require("rubik.basic-object.object")

-- ---------------------------------------------------------------------

local FalseClass = class("FalseClass", Object)

-- ---------------------------------------------------------------------
-- Class
-- ---------------------------------------------------------------------

-- FalseClass::fromLiteral
-- ---------------------------------------------------------------------

function FalseClass.static.fromLiteral()
  local newFalse = FalseClass:new()

  newFalse.__lua = false

  return newFalse
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
