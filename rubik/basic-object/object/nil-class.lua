-- NilClass
-- ---------------------------------------------------------------------

local class = require("middleclass")

local Object = require("rubik.basic-object.object")

-- ---------------------------------------------------------------------

local NilClass = class("NilClass", Object)

-- ---------------------------------------------------------------------
-- Class
-- ---------------------------------------------------------------------

-- NilClass::new (Rubik Only)
-- ---------------------------------------------------------------------

function NilClass:initialize()
  self.__lua = nil
end

-- NilClass::fromLiteral

function NilClass.static.fromLiteral()
  return NilClass:new()
end

-- ---------------------------------------------------------------------
-- Instance
-- ---------------------------------------------------------------------

-- NilClass#derubik
-- ---------------------------------------------------------------------

function NilClass:derubik()
  return self.__lua
end

-- ---------------------------------------------------------------------

return NilClass
