-- Object
-- ---------------------------------------------------------------------

local class = require("middleclass")

local BasicObject = require("rubik.basic-object")

-- ---------------------------------------------------------------------

local Object = class("Object", BasicObject)

-- ---------------------------------------------------------------------
-- Class
-- ---------------------------------------------------------------------

-- Object::wrap
-- ---------------------------------------------------------------------

function Object.static.wrap(literal)
  local o = Object:new()

  o.__recipe = literal

  return o
end

-- ---------------------------------------------------------------------

return Object
