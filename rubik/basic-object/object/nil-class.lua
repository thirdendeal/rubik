-- NilClass
-- ---------------------------------------------------------------------

local class = require("middleclass")

local Object = require("rubik.basic-object.object")

-- ---------------------------------------------------------------------

local NilClass = class("NilClass", Object)

-- ---------------------------------------------------------------------
-- Class
-- ---------------------------------------------------------------------

-- NilClass::fromLiteral
-- ---------------------------------------------------------------------

function NilClass.static.fromLiteral()
  local newNil = NilClass:new()

  newNil.__lua = nil

  return newNil
end

-- ---------------------------------------------------------------------

return NilClass
