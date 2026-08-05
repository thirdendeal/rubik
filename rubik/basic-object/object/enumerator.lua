-- Enumerator
-- ---------------------------------------------------------------------

local class = require("middleclass")

local Object = require("rubik.basic-object.object")

-- ---------------------------------------------------------------------

local Enumerator = class("Enumerator", Object)

-- ---------------------------------------------------------------------
-- Class
-- ---------------------------------------------------------------------

-- Enumerator::new (Rubik + Ruby)
-- ---------------------------------------------------------------------

function Enumerator:initialize(size, block)
  self.size = size
  self.__block = block

  self:rewind()
end

-- Enumerator::produce
-- ---------------------------------------------------------------------

function Enumerator.static.produce(initial, block)
  return Enumerator:new(_, function()
    local current = initial

    while true do
      coroutine.yield(current)

      current = block(current)
    end
  end)
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
    local success, nextValue = coroutine.resume(self.__coroutine)

    if success then
      return nextValue
    else
      error("StopIteration", 2)
    end
  end
end

-- Enumerator#peek
-- ---------------------------------------------------------------------

function Enumerator:peek()
  local success = true

  if not self.__hasPeeked then
    self.__hasPeeked = true

    success, self.__peekValue = coroutine.resume(self.__coroutine)
  end

  if success then
    return self.__peekValue
  else
    error("StopIteration", 2)
  end
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
