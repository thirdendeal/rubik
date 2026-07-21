-- Numeric
-- ---------------------------------------------------------------------

local class = require("middleclass")

local Object = require("rubik.basic-object.object")
-- ---------------------------------------------------------------------

local Numeric = class("Numeric", Object)

-- ---------------------------------------------------------------------
-- Class
-- ---------------------------------------------------------------------

-- Numeric::wrap
-- ---------------------------------------------------------------------

function Numeric.static.wrap(value)
  local n = Numeric:new()

  n.__recipe = value

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

-- ---------------------------------------------------------------------

return Numeric
