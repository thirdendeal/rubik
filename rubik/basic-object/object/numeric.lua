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

-- Numeric::wrap
-- ---------------------------------------------------------------------

function Numeric.static.wrap(literal)
  local n = Numeric:new()

  n.__recipe = literal
  n.class.rubik.patch_quote_methods(n, _QUOTE_METHODS)

  return n
end

-- ---------------------------------------------------------------------
-- Instance
-- ---------------------------------------------------------------------

-- Numeric#floor
-- ---------------------------------------------------------------------

function Numeric:floor(ndigits)
  local f = self.class.rubik.Float.wrap(self.__recipe)

  return f:floor(ndigits)
end

-- Numeric#ceil
-- ---------------------------------------------------------------------

function Numeric:ceil(ndigits)
  local f = self.class.rubik.Float.wrap(self.__recipe)

  return f:ceil(ndigits)
end

-- Numeric#round
-- ---------------------------------------------------------------------

function Numeric:round(ndigits)
  local f = self.class.rubik.Float.wrap(self.__recipe)

  return f:round(ndigits)
end

-- Numeric#modulo
-- ---------------------------------------------------------------------

function Numeric:modulo(other)
  return self.class.rubik(self.__recipe % other)
end

-- Numeric#positive?
-- ---------------------------------------------------------------------

Numeric["positive?"] = function(self)
  return self.class.rubik(self.__recipe > 0)
end

-- Numeric#negative?
-- ---------------------------------------------------------------------

Numeric["negative?"] = function(self)
  return self.class.rubik(self.__recipe < 0)
end

-- Numeric#zero?
-- ---------------------------------------------------------------------

Numeric["zero?"] = function(self)
  return self.class.rubik(self.__recipe == 0)
end

-- Numeric#nonzero?
-- ---------------------------------------------------------------------

Numeric["nonzero?"] = function(self)
  return self.class.rubik(self.__recipe ~= 0)
end

-- ---------------------------------------------------------------------

return Numeric
