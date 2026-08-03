-- Object
-- ---------------------------------------------------------------------

local class = require("middleclass")

local BasicObject = require("rubik.basic-object")

-- ---------------------------------------------------------------------

local Object = class("Object", BasicObject)

-- ---------------------------------------------------------------------
-- Class
-- ---------------------------------------------------------------------

-- Object::fromLiteral
-- ---------------------------------------------------------------------

function Object.static.fromLiteral(value)
  local newObject = Object:new()

  newObject.__lua = value

  return newObject
end

-- ---------------------------------------------------------------------

return Object
