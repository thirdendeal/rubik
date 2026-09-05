-- Numeric
-- ---------------------------------------------------------------------

local class = require("middleclass")

local Object = require("rubik.basic-object.object")

-- ---------------------------------------------------------------------

local Numeric = class("Numeric", Object)

-- ---------------------------------------------------------------------
-- Private
-- ---------------------------------------------------------------------

local __QUOTED_METHODS = { "positive?", "negative?", "zero?", "nonzero?" }

-- ---------------------------------------------------------------------
-- Class
-- ---------------------------------------------------------------------

-- Numeric::new (Rubik Only)
-- ---------------------------------------------------------------------

function Numeric:initialize(number)
  self.__lua = number

  Numeric.rubik.patch_quoted_methods(self, __QUOTED_METHODS)
end

-- Numeric::fromLiteral

function Numeric.static.fromLiteral(number)
  return Numeric:new(number)
end

-- ---------------------------------------------------------------------
-- Instance
-- ---------------------------------------------------------------------

-- Numeric#floor
-- ---------------------------------------------------------------------

function Numeric:floor(ndigits)
  local f = Numeric.rubik("Float", self.__lua)

  return f:floor(ndigits)
end

-- Numeric#ceil
-- ---------------------------------------------------------------------

function Numeric:ceil(ndigits)
  local f = Numeric.rubik("Float", self.__lua)

  return f:ceil(ndigits)
end

-- Numeric#round
-- ---------------------------------------------------------------------

function Numeric:round(ndigits)
  local f = Numeric.rubik("Float", self.__lua)

  return f:round(ndigits)
end

-- Numeric#modulo
-- ---------------------------------------------------------------------

function Numeric:modulo(other)
  return Numeric.rubik(self.__lua % other)
end

-- Numeric#positive?
-- ---------------------------------------------------------------------

Numeric["positive?"] = function(self)
  return Numeric.rubik(self.__lua > 0)
end

-- Numeric#negative?
-- ---------------------------------------------------------------------

Numeric["negative?"] = function(self)
  return Numeric.rubik(self.__lua < 0)
end

-- Numeric#zero?
-- ---------------------------------------------------------------------

Numeric["zero?"] = function(self)
  return Numeric.rubik(self.__lua == 0)
end

-- Numeric#nonzero?
-- ---------------------------------------------------------------------

Numeric["nonzero?"] = function(self)
  return Numeric.rubik(self.__lua ~= 0)
end

-- ---------------------------------------------------------------------

return Numeric
