-- Object
-- ---------------------------------------------------------------------

local class = require("middleclass")

-- ---------------------------------------------------------------------

local Object = class("Object")

-- Object::wrap
-- ---------------------------------------------------------------------

function Object.static.wrap(value)
  local object = Object:new()

  object.__recipe = value

  return object
end

-- Object#unwrap
-- ---------------------------------------------------------------------

function Object:unwrap()
  return self.__recipe
end

-- Object#derubik alias

function Object:derubik()
  return self:unwrap()
end

-- ---------------------------------------------------------------------

return Object
