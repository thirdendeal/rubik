-- Hash
-- ---------------------------------------------------------------------

local class = require("middleclass")

local Object = require("rubik.basic-object.object")

-- ---------------------------------------------------------------------

local Hash = class("Hash", Object)

-- ---------------------------------------------------------------------
-- Private
-- ---------------------------------------------------------------------

local __QUOTED_METHODS = { "empty?" }

-- ---------------------------------------------------------------------

local __get_default = function(self, key)
  if self.__default_proc then
    return self.__default_proc(self, key)
  else
    return self.__default
  end
end

-- ---------------------------------------------------------------------
-- Class
-- ---------------------------------------------------------------------

-- Hash::new (Rubik + Ruby)
-- ---------------------------------------------------------------------

function Hash:initialize(t)
  self.__lua = {}
  self.__orderedKeys = Hash.rubik.Array:new() -- TODO: Use Set

  Hash.rubik.patch_quoted_methods(self, __QUOTED_METHODS)

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

-- Hash#access
-- ---------------------------------------------------------------------
--
-- Ruby's Hash#[]

function Hash:__index(key)
  if self.__lua[key] == nil then
    if key == "__default" then
      return rawget(self, "__default")
    end

    if key == "__default_proc" then
      return rawget(self, "__default_proc")
    end

    return Hash.rubik(__get_default(self, key))
  else
    return Hash.rubik(self.__lua[key])
  end
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

-- Hash#size
-- ---------------------------------------------------------------------

function Hash:size()
  return self.__orderedKeys:size()
end

-- Hash#length alias

function Hash:length()
  return self:size()
end

-- Hash#empty?
-- ---------------------------------------------------------------------

Hash["empty?"] = function(self)
  return Hash.rubik(self:size()[":zero?"]())
end

-- Hash#__newindex metamethod
-- ---------------------------------------------------------------------

-- Hash#default=
-- Hash#default_proc=

function Hash:__newindex(key, value)
  if key == "default" then
    self.__default = value
    self.__default_proc = nil
  elseif key == "default_proc" then
    self.__default_proc = value
    self.__default = nil
  else
    rawset(self, key, value)
  end
end

-- Hash#default
-- ---------------------------------------------------------------------

function Hash:default(key)
  if key == nil then
    return Hash.rubik(self.__default)
  else
    return Hash.rubik(__get_default(self, key))
  end
end

-- Hash#default_proc
-- ---------------------------------------------------------------------

function Hash:default_proc()
  return Hash.rubik(self.__default_proc)
end

-- ---------------------------------------------------------------------

return Hash
