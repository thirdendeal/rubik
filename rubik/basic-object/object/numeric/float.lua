-- Float
-- ---------------------------------------------------------------------

local class = require("middleclass")

local Numeric = require("rubik.basic-object.object.numeric")

-- ---------------------------------------------------------------------

local Float = class("Float", Numeric)

-- ---------------------------------------------------------------------
-- Class
-- ---------------------------------------------------------------------

-- Float::wrap
-- ---------------------------------------------------------------------

function Float.static.wrap(literal)
  local f = Float:new()

  f.__recipe = literal

  return f
end

-- ---------------------------------------------------------------------
-- Instance
-- ---------------------------------------------------------------------

-- Float#floor
-- ---------------------------------------------------------------------

function Float:floor(ndigits)
  local ndigits = ndigits or 0
  local modfier = math.pow(10, ndigits)

  local f = math.floor(self.__recipe * modfier) / modfier

  return self.class.rubik(f)
end

-- Float#ceil
-- ---------------------------------------------------------------------

function Float:ceil(ndigits)
  local ndigits = ndigits or 0
  local modfier = math.pow(10, ndigits)

  local f = math.ceil(self.__recipe * modfier) / modfier

  return self.class.rubik(f)
end

-- Float#round
-- ---------------------------------------------------------------------

function Float:round(ndigits)
  local ndigits = ndigits or 0
  local modfier = math.pow(10, ndigits)

  local f = math.floor((self.__recipe * modfier) + 0.5) / modfier

  return self.class.rubik(f)
end

-- ---------------------------------------------------------------------

return Float
