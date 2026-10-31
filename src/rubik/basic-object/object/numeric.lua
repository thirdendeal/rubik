-- Numeric
-- -----------------------------------------------------------------------------

local class = require("middleclass")

local Object = require(CWD .. "rubik.basic-object.object")

-- -----------------------------------------------------------------------------

local Numeric = class("Numeric", Object)

-- -----------------------------------------------------------------------------
-- Constants
-- -----------------------------------------------------------------------------

local __QUOTE_METHODS = {
  "positive?",
  "negative?",
  "zero?",
  "nonzero?"
}

-- -----------------------------------------------------------------------------
-- Public Class Methods
-- -----------------------------------------------------------------------------

-- Numeric::new
-- -----------------------------------------------------------------------------

function Numeric:initialize(number)
  Object.initialize(self, number)

  Numeric.rubik.patch_quote_methods(self, __QUOTE_METHODS)
end

-- -----------------------------------------------------------------------------
-- Public Instance Methods
-- -----------------------------------------------------------------------------

-- Numeric#floor
-- -----------------------------------------------------------------------------

function Numeric:floor(ndigits)
  local f = Numeric.rubik("Float", self.__literal)

  return f:floor(ndigits)
end

-- Numeric#ceil
-- -----------------------------------------------------------------------------

function Numeric:ceil(ndigits)
  local f = Numeric.rubik("Float", self.__literal)

  return f:ceil(ndigits)
end

-- Numeric#round
-- -----------------------------------------------------------------------------

function Numeric:round(ndigits)
  local f = Numeric.rubik("Float", self.__literal)

  return f:round(ndigits)
end

-- Numeric#modulo
-- -----------------------------------------------------------------------------

function Numeric:modulo(other)
  return Numeric.rubik(self.__literal % other)
end

-- Numeric#positive?
-- -----------------------------------------------------------------------------

Numeric["positive?"] = function(self)
  return Numeric.rubik(self.__literal > 0)
end

-- Numeric#negative?
-- -----------------------------------------------------------------------------

Numeric["negative?"] = function(self)
  return Numeric.rubik(self.__literal < 0)
end

-- Numeric#zero?
-- -----------------------------------------------------------------------------

Numeric["zero?"] = function(self)
  return Numeric.rubik(self.__literal == 0)
end

-- Numeric#nonzero?
-- -----------------------------------------------------------------------------

Numeric["nonzero?"] = function(self)
  return Numeric.rubik(self.__literal ~= 0)
end

-- -----------------------------------------------------------------------------

return Numeric
