-- BasicObject
-- ---------------------------------------------------------------------

local class = require("middleclass")

-- ---------------------------------------------------------------------

local BasicObject = class("BasicObject")

-- ---------------------------------------------------------------------
-- Class
-- ---------------------------------------------------------------------

-- BasicObject::new (Rubik + Ruby)
-- ---------------------------------------------------------------------

function BasicObject:initialize(value)
  self.__lua = value
end

-- BasicObject::fromLiteral

function BasicObject.static.fromLiteral(value)
  return BasicObject:new(value)
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
