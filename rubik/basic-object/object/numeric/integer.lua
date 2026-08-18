-- Integer
-- ---------------------------------------------------------------------

local class = require("middleclass")

local Numeric = require("rubik.basic-object.object.numeric")

-- ---------------------------------------------------------------------

local Integer = class("Integer", Numeric)

-- ---------------------------------------------------------------------
-- Private
-- ---------------------------------------------------------------------

local __QUOTED_METHODS = { "even?", "odd?", "zero?" }

-- ---------------------------------------------------------------------
-- Class
-- ---------------------------------------------------------------------

-- Integer::new (Rubik Only)
-- ---------------------------------------------------------------------

function Integer:initialize(number)
  local integerPart, _ = math.modf(number)
  self.__lua = integerPart

  Integer.rubik.patch_quoted_methods(self, __QUOTED_METHODS)
end

-- Integer::fromLiteral

function Integer.static.fromLiteral(number)
  return Integer:new(number)
end

-- ---------------------------------------------------------------------
-- Instance
-- ---------------------------------------------------------------------

-- Integer#even?
-- ---------------------------------------------------------------------

Integer["even?"] = function(self)
  return Integer.rubik((self.__lua % 2) == 0)
end

-- Integer#odd?
-- ---------------------------------------------------------------------

Integer["odd?"] = function(self)
  return Integer.rubik((self.__lua % 2) ~= 0)
end

-- Integer#zero?
-- ---------------------------------------------------------------------

Integer["zero?"] = function(self)
  return Integer.rubik(self.__lua == 0)
end

-- Integer#abs
-- ---------------------------------------------------------------------

function Integer:abs()
  return Integer.rubik(math.abs(self.__lua))
end

-- Integer#magnitude alias

function Integer:magnitude()
  return self:abs()
end

-- Integer#succ
-- ---------------------------------------------------------------------

function Integer:succ()
  return Integer.rubik(self.__lua + 1)
end

-- Integer#next alias

function Integer:next()
  return self:succ()
end

-- ---------------------------------------------------------------------

return Integer
