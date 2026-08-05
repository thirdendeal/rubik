-- TrueClass
-- ---------------------------------------------------------------------

local class = require("middleclass")

local Object = require("rubik.basic-object.object")

-- ---------------------------------------------------------------------

local TrueClass = class("TrueClass", Object)

-- ---------------------------------------------------------------------
-- Class
-- ---------------------------------------------------------------------

-- TrueClass::new (Rubik Only)
-- ---------------------------------------------------------------------

function TrueClass:initialize()
  self.__lua = true
end

-- TrueClass::fromLiteral

function TrueClass.static.fromLiteral()
  return TrueClass:new()
end

-- ---------------------------------------------------------------------

return TrueClass
