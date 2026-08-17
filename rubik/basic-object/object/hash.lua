-- Hash
-- ---------------------------------------------------------------------

local class = require("middleclass")

local Object = require("rubik.basic-object.object")

-- ---------------------------------------------------------------------

local Hash = class("Hash", Object)

-- ---------------------------------------------------------------------
-- Class
-- ---------------------------------------------------------------------

-- Hash::new (Rubik + Ruby)
-- ---------------------------------------------------------------------

function Hash:initialize(t)
  self.__lua = t
end

-- Hash::fromLiteral
-- ---------------------------------------------------------------------

function Hash.static.fromLiteral(t)
  return Hash:new(t)
end

-- ---------------------------------------------------------------------
-- Instance
-- ---------------------------------------------------------------------

-- Hash#[]
-- ---------------------------------------------------------------------

function Hash:__index(key)
  return Hash.rubik(self.__lua[key])
end

-- Hash#store
-- ---------------------------------------------------------------------

function Hash:store(key, value)
  self.__lua[key] = value

  return Hash.rubik(value)
end

-- Hash#delete
-- ---------------------------------------------------------------------

function Hash:delete(key)
  local value = self[key]

  self:store(key, nil)

  return Hash.rubik(value)
end

-- ---------------------------------------------------------------------

return Hash
