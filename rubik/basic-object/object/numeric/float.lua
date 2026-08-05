-- Float
-- ---------------------------------------------------------------------

local class = require("middleclass")

local Numeric = require("rubik.basic-object.object.numeric")

-- ---------------------------------------------------------------------

local Float = class("Float", Numeric)

-- ---------------------------------------------------------------------
-- Class
-- ---------------------------------------------------------------------

-- Float::fromLiteral
-- ---------------------------------------------------------------------

function Float.static.fromLiteral(number)
  local newFloat = Float:new()

  newFloat.__lua = number

  return newFloat
end

-- ---------------------------------------------------------------------
-- Instance
-- ---------------------------------------------------------------------

-- Float#floor
-- ---------------------------------------------------------------------

function Float:floor(ndigits)
  local ndigits = ndigits or 0
  local modfier = math.pow(10, ndigits)

  local f = math.floor(self.__lua * modfier) / modfier

  return Float.rubik(f)
end

-- Float#ceil
-- ---------------------------------------------------------------------

function Float:ceil(ndigits)
  local ndigits = ndigits or 0
  local modfier = math.pow(10, ndigits)

  local f = math.ceil(self.__lua * modfier) / modfier

  return Float.rubik(f)
end

-- Float#round
-- ---------------------------------------------------------------------

function Float:round(ndigits)
  local ndigits = ndigits or 0
  local modfier = math.pow(10, ndigits)

  local f = math.floor((self.__lua * modfier) + 0.5) / modfier

  return Float.rubik(f)
end

-- ---------------------------------------------------------------------

return Float
