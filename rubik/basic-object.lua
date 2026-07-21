-- BasicObject
-- ---------------------------------------------------------------------

local class = require("middleclass")

-- ---------------------------------------------------------------------

local BasicObject = class("BasicObject")

-- ---------------------------------------------------------------------
-- Class
-- ---------------------------------------------------------------------

-- BasicObject::wrap
-- ---------------------------------------------------------------------

function BasicObject.static.wrap(literal)
  local o = BasicObject:new()

  o.__recipe = literal

  return o
end

-- ---------------------------------------------------------------------
-- Instance
-- ---------------------------------------------------------------------

-- BasicObject#unwrap
-- ---------------------------------------------------------------------

function BasicObject:unwrap()
  return self.__recipe
end

-- BasicObject#derubik alias

function BasicObject:derubik()
  return self:unwrap()
end

-- ---------------------------------------------------------------------

return BasicObject
