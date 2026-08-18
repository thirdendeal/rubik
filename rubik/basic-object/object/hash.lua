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
  self.__lua = {}
  self.__orderedKeys = Hash.rubik.Array:new() -- TODO: Use Set

  for key, value in pairs(t) do
    self:store(key, value)
  end
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
  if value == nil then
    self.__orderedKeys:delete(key)
  else
    if not self.__lua[key] then
      self.__orderedKeys:push(key)
    end
  end

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

-- Hash#keys
-- ---------------------------------------------------------------------

function Hash:keys()
  return self.__orderedKeys
end

-- Hash#values
-- ---------------------------------------------------------------------

function Hash:values()
  local orderedValues = {}

  self.__orderedKeys:each(function(key)
    table.insert(orderedValues, self.__lua[key])
  end)

  return Hash.rubik(orderedValues)
end

-- ---------------------------------------------------------------------

return Hash
