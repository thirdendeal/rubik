-- Object
-- -----------------------------------------------------------------------------

local class = require("middleclass")

local BasicObject = require(CWD .. "rubik.basic-object")

-- -----------------------------------------------------------------------------

local Object = class("Object", BasicObject)

-- -----------------------------------------------------------------------------
-- Class
-- -----------------------------------------------------------------------------

-- Object::new (Rubik Only)
-- -----------------------------------------------------------------------------

function Object:initialize(value)
  self.__lua = value
end

-- Object::fromLiteral

function Object.static.fromLiteral(literal)
  return Object:new(literal)
end

-- -----------------------------------------------------------------------------

return Object
