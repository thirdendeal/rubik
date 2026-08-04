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
  if self.__lua then
    return self.__lua
  else
    error("NoLuaEquivalent")
  end
end

-- ---------------------------------------------------------------------

return BasicObject
