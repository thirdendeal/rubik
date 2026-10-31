-- Float
-- -----------------------------------------------------------------------------

local class = require("middleclass")

local Numeric = require(CWD .. "rubik.basic-object.object.numeric")

-- -----------------------------------------------------------------------------

local Float = class("Float", Numeric)

-- -----------------------------------------------------------------------------
-- Public Class Methods
-- -----------------------------------------------------------------------------

-- Float::new
-- -----------------------------------------------------------------------------

function Float:initialize(number)
  Numeric.initialize(self, number)
end

-- -----------------------------------------------------------------------------
-- Public Instance Methods
-- -----------------------------------------------------------------------------

-- Float#floor
-- -----------------------------------------------------------------------------

function Float:floor(ndigits)
  local ndigits = ndigits or 0
  local modfier = math.pow(10, ndigits)

  local f = math.floor(self.__literal * modfier) / modfier

  return Float.rubik(f)
end

-- Float#ceil
-- -----------------------------------------------------------------------------

function Float:ceil(ndigits)
  local ndigits = ndigits or 0
  local modfier = math.pow(10, ndigits)

  local f = math.ceil(self.__literal * modfier) / modfier

  return Float.rubik(f)
end

-- Float#round
-- -----------------------------------------------------------------------------

function Float:round(ndigits)
  local ndigits = ndigits or 0
  local modfier = math.pow(10, ndigits)

  local f = math.floor((self.__literal * modfier) + 0.5) / modfier

  return Float.rubik(f)
end

-- -----------------------------------------------------------------------------

return Float
