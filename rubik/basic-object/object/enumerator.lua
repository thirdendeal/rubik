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
  self.__size = size
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
      return Enumerator.rubik(nextValue)
    else
      error("StopIteration", 2)
    end
  end
end

-- Enumerator#next_values
-- ---------------------------------------------------------------------

function Enumerator:next_values()
  return Enumerator.rubik({}):push(self:next():derubik())
end

-- Enumerator#peek
-- ---------------------------------------------------------------------

function Enumerator:peek()
  local success = true

  if not self.__hasPeeked then
    self.__hasPeeked = true
    success, self.__peekValue = coroutine.resume(self.__coroutine)

    self.__peekValue = Enumerator.rubik(self.__peekValue)
  end

  if success then
    return self.__peekValue
  else
    error("StopIteration", 2)
  end
end

-- Enumerator#peek_values
-- ---------------------------------------------------------------------

function Enumerator:peek_values()
  return Enumerator.rubik({}):push(self:peek():derubik())
end

-- Enumerator#rewind
-- ---------------------------------------------------------------------

function Enumerator:rewind()
  self.__coroutine = coroutine.create(self.__block)
  self.__hasPeeked = false

  return self
end

-- Enumerator#size
-- ---------------------------------------------------------------------

-- TODO: Handle `__size` being either a value or a callable object

function Enumerator:size()
  return Enumerator.rubik(self.__size)
end

-- ---------------------------------------------------------------------

return Enumerator
