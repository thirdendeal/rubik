-- Integer
-- -----------------------------------------------------------------------------

local class = require("middleclass")

local Numeric = require(CWD .. "rubik.basic-object.object.numeric")

-- -----------------------------------------------------------------------------

local Integer = class("Integer", Numeric)

-- -----------------------------------------------------------------------------
-- Constants
-- -----------------------------------------------------------------------------

local __QUOTE_METHODS = {
  "even?",
  "odd?",
  "zero?"
}

-- -----------------------------------------------------------------------------
-- Public Class Methods
-- -----------------------------------------------------------------------------

-- Integer::new
-- -----------------------------------------------------------------------------

function Integer:initialize(number)
  local integer, _ = math.modf(number)

  Numeric.initialize(self, integer)

  Integer.rubik.patch_quote_methods(self, __QUOTE_METHODS)
end

-- -----------------------------------------------------------------------------
-- Public Instance Methods
-- -----------------------------------------------------------------------------

-- Integer#even?
-- -----------------------------------------------------------------------------

Integer["even?"] = function(self)
  return Integer.rubik((self.__literal % 2) == 0)
end

-- Integer#odd?
-- -----------------------------------------------------------------------------

Integer["odd?"] = function(self)
  return Integer.rubik((self.__literal % 2) ~= 0)
end

-- Integer#zero?
-- -----------------------------------------------------------------------------

Integer["zero?"] = function(self)
  return Integer.rubik(self.__literal == 0)
end

-- Integer#abs
-- -----------------------------------------------------------------------------

function Integer:abs()
  return Integer.rubik(math.abs(self.__literal))
end

-- Integer#magnitude alias

function Integer:magnitude()
  return self:abs()
end

-- Integer#succ
-- -----------------------------------------------------------------------------

function Integer:succ()
  return Integer.rubik(self.__literal + 1)
end

-- Integer#next alias

function Integer:next()
  return self:succ()
end

-- -----------------------------------------------------------------------------

return Integer
