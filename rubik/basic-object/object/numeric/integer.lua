-- Integer
-- ---------------------------------------------------------------------

local class = require("middleclass")

local Numeric = require("rubik.basic-object.object.numeric")

-- ---------------------------------------------------------------------

local Integer = class("Integer", Numeric)

-- ---------------------------------------------------------------------
-- Private
-- ---------------------------------------------------------------------

local _QUOTE_METHODS = { "even?", "odd?", "zero?" }

-- ---------------------------------------------------------------------
-- Class
-- ---------------------------------------------------------------------

-- Integer::wrap
-- ---------------------------------------------------------------------

function Integer.static.wrap(literal)
  local i = Integer:new()

  i.__recipe = literal
  i.class.rubik.patch_quote_methods(i, _QUOTE_METHODS)

  return i
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
