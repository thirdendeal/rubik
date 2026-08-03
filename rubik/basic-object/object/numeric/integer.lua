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

-- Integer::fromLiteral
-- ---------------------------------------------------------------------

function Integer.static.fromLiteral(number)
  local newInteger = Integer:new()

  local integerPart, _ = math.modf(number)

  newInteger.__lua = integerPart
  Integer.rubik.patch_quote_methods(newInteger, _QUOTE_METHODS)

  return newInteger
end

-- ---------------------------------------------------------------------
-- Instance
-- ---------------------------------------------------------------------

-- Integer#even?
-- ---------------------------------------------------------------------

Integer["even?"] = function(self)
  return self.class.rubik((self.__lua % 2) == 0)
end

-- Integer#odd?
-- ---------------------------------------------------------------------

Integer["odd?"] = function(self)
  return self.class.rubik((self.__lua % 2) ~= 0)
end

-- Integer#zero?
-- ---------------------------------------------------------------------

Integer["zero?"] = function(self)
  return self.class.rubik(self.__lua == 0)
end

-- Integer#abs
-- ---------------------------------------------------------------------

function Integer:abs()
  return self.class.rubik(math.abs(self.__lua))
end

-- Integer#magnitude alias

function Integer:magnitude()
  return self:abs()
end

-- ---------------------------------------------------------------------

return Integer
