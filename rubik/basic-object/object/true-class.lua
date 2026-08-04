-- TrueClass
-- ---------------------------------------------------------------------

local class = require("middleclass")

local Object = require("rubik.basic-object.object")

-- ---------------------------------------------------------------------

local TrueClass = class("TrueClass", Object)

-- ---------------------------------------------------------------------
-- Class
-- ---------------------------------------------------------------------

-- TrueClass::fromLiteral
-- ---------------------------------------------------------------------

function TrueClass.static.fromLiteral()
  local newTrue = TrueClass:new()

  newTrue.__lua = true

  return newTrue
end

-- ---------------------------------------------------------------------

return TrueClass
