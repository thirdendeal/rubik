-- BasicObject
-- -----------------------------------------------------------------------------

local class = require("middleclass")

-- -----------------------------------------------------------------------------

local BasicObject = class("BasicObject")

-- -----------------------------------------------------------------------------
-- Public Class Methods
-- -----------------------------------------------------------------------------

-- BasicObject::new
-- -----------------------------------------------------------------------------

function BasicObject:initialize(literal)
  self.__literal = literal
end

-- BasicObject::__new
-- -----------------------------------------------------------------------------

function BasicObject.static.__new(literal)
  return BasicObject:new(literal)
end

-- -----------------------------------------------------------------------------
-- Public Instance Methods
-- -----------------------------------------------------------------------------

-- BasicObject#derubik
-- -----------------------------------------------------------------------------

function BasicObject:derubik()
  if self.__literal then
    return self.__literal
  else
    error("NoLuaEquivalent")
  end
end

-- -----------------------------------------------------------------------------

return BasicObject
