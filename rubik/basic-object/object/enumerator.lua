-- Enumerator
-- ---------------------------------------------------------------------

local class = require("middleclass")

local Object = require("rubik.basic-object.object")

-- ---------------------------------------------------------------------

local Enumerator = class("Enumerator", Object)

-- ---------------------------------------------------------------------
-- Class
-- ---------------------------------------------------------------------

-- Enumerator::wrap
-- ---------------------------------------------------------------------

function Enumerator.static.wrap(recipe)
  return Enumerator:new(unpack(recipe))
end

-- Enumerator::new

function Enumerator:initialize(size, block)
  self.size = size
  self.__block = block

  self:rewind()
end

-- ---------------------------------------------------------------------
-- Instance
-- ---------------------------------------------------------------------

-- Enumerator#next
-- ---------------------------------------------------------------------

function Enumerator:next()
  if self.__hasPeeked then
    self.__hasPeeked = false

    return self.__peekValue
  else
    local _, nextValue = coroutine.resume(self.__coroutine)

    return nextValue
  end
end

-- Enumerator#peek
-- ---------------------------------------------------------------------

function Enumerator:peek()
  if not self.__hasPeeked then
    self.__hasPeeked = true

    _, self.__peekValue = coroutine.resume(self.__coroutine)
  end

  return self.__peekValue
end

-- Enumerator#rewind
-- ---------------------------------------------------------------------

function Enumerator:rewind()
  self.__coroutine = coroutine.create(self.__block)
  self.__hasPeeked = false

  return self
end

-- ---------------------------------------------------------------------

return Enumerator
