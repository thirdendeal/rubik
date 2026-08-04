-- Numeric
-- ---------------------------------------------------------------------

local class = require("middleclass")

local Object = require("rubik.basic-object.object")

-- ---------------------------------------------------------------------

local Numeric = class("Numeric", Object)

-- ---------------------------------------------------------------------
-- Private
-- ---------------------------------------------------------------------

local _QUOTE_METHODS = { "positive?", "negative?", "zero?", "nonzero?" }

-- ---------------------------------------------------------------------
-- Class
-- ---------------------------------------------------------------------

-- Numeric::fromLiteral
-- ---------------------------------------------------------------------

function Numeric.static.fromLiteral(number)
  local newNumeric = Numeric:new()

  newNumeric.__lua = number
  Numeric.rubik.patch_quote_methods(newNumeric, _QUOTE_METHODS)

  return newNumeric
end

-- ---------------------------------------------------------------------
-- Instance
-- ---------------------------------------------------------------------

-- Numeric#floor
-- ---------------------------------------------------------------------

function Numeric:floor(ndigits)
  local f = self.class.rubik.Float.fromLiteral(self.__lua)

  return f:floor(ndigits)
end

-- Numeric#ceil
-- ---------------------------------------------------------------------

function Numeric:ceil(ndigits)
  local f = self.class.rubik.Float.fromLiteral(self.__lua)

  return f:ceil(ndigits)
end

-- Numeric#round
-- ---------------------------------------------------------------------

function Numeric:round(ndigits)
  local f = self.class.rubik.Float.fromLiteral(self.__lua)

  return f:round(ndigits)
end

-- Numeric#modulo
-- ---------------------------------------------------------------------

function Numeric:modulo(other)
  return self.class.rubik(self.__lua % other)
end

-- Numeric#positive?
-- ---------------------------------------------------------------------

Numeric["positive?"] = function(self)
  return self.class.rubik(self.__lua > 0)
end

-- Numeric#negative?
-- ---------------------------------------------------------------------

Numeric["negative?"] = function(self)
  return self.class.rubik(self.__lua < 0)
end

-- Numeric#zero?
-- ---------------------------------------------------------------------

Numeric["zero?"] = function(self)
  return self.class.rubik(self.__lua == 0)
end

-- Numeric#nonzero?
-- ---------------------------------------------------------------------

Numeric["nonzero?"] = function(self)
  return self.class.rubik(self.__lua ~= 0)
end

-- ---------------------------------------------------------------------

return Numeric
