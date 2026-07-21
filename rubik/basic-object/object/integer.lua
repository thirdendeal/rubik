-- Integer
-- ---------------------------------------------------------------------

local class = require("middleclass")

local Object = require("rubik.basic-object.object")

-- ---------------------------------------------------------------------

local Integer = class("Integer", Object)

-- ---------------------------------------------------------------------
-- Private
-- ---------------------------------------------------------------------

local _QUOTE_METHODS = { "even?", "odd?", "zero?" }

-- ---------------------------------------------------------------------
-- Class
-- ---------------------------------------------------------------------

-- Integer::wrap
-- ---------------------------------------------------------------------

function Integer.static.wrap(value)
  local object = Integer:new()

  object.__recipe = value
  object.class.rubik.patch_quote_methods(object, _QUOTE_METHODS)

  return object
end

-- ---------------------------------------------------------------------
-- Instance
-- ---------------------------------------------------------------------

-- Integer#even?
-- ---------------------------------------------------------------------

Integer["even?"] = function(self)
  return self.class.rubik((self.__recipe % 2) == 0)
end

-- Integer#odd?
-- ---------------------------------------------------------------------

Integer["odd?"] = function(self)
  return self.class.rubik((self.__recipe % 2) ~= 0)
end

-- Integer#zero?
-- ---------------------------------------------------------------------

Integer["zero?"] = function(self)
  return self.class.rubik(self.__recipe == 0)
end

-- Integer#abs
-- ---------------------------------------------------------------------

function Integer:abs()
  return self.class.rubik(math.abs(self.__recipe))
end

-- Integer#magnitude alias

function Integer:magnitude()
  return self:abs()
end

-- ---------------------------------------------------------------------

return Integer
