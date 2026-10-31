-- Object
-- -----------------------------------------------------------------------------

local class = require("middleclass")

local BasicObject = require(CWD .. "rubik.basic-object")

-- -----------------------------------------------------------------------------

local Object = class("Object", BasicObject)

-- -----------------------------------------------------------------------------
-- Public Class Methods
-- -----------------------------------------------------------------------------

-- Object::new
-- -----------------------------------------------------------------------------

function Object:initialize(literal)
  BasicObject.initialize(self, literal)
end

-- Object::__new
-- -----------------------------------------------------------------------------

function Object.static.__new(literal)
  return Object:new(literal)
end

-- -----------------------------------------------------------------------------

return Object
