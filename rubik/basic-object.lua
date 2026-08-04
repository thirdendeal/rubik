-- BasicObject
-- ---------------------------------------------------------------------

local class = require("middleclass")

-- ---------------------------------------------------------------------

local BasicObject = class("BasicObject")

-- ---------------------------------------------------------------------
-- Class
-- ---------------------------------------------------------------------

-- BasicObject::fromLiteral
-- ---------------------------------------------------------------------

function BasicObject.static.fromLiteral(value)
  local newBasicObject = BasicObject:new()

  newBasicObject.__lua = value

  return newBasicObject
end

-- ---------------------------------------------------------------------
-- Instance
-- ---------------------------------------------------------------------

-- BasicObject#derubik
-- ---------------------------------------------------------------------

function BasicObject:derubik()
  return self.__lua
end

-- ---------------------------------------------------------------------

return BasicObject
