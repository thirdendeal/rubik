-- Enumerator
-- ---------------------------------------------------------------------

local class = require("middleclass")

local Object = require("rubik.basic-object.object")

-- ---------------------------------------------------------------------

local Enumerator = class("Enumerator", Object)

-- ---------------------------------------------------------------------
-- Class
-- ---------------------------------------------------------------------

-- Enumerator::new
-- ---------------------------------------------------------------------

function Enumerator:initialize(x, y)
  if y then
    self.size, self.newStepClosure = x, y
  else
    self.newStepClosure = x
  end

  self.step = self.newStepClosure()
end

-- ---------------------------------------------------------------------
-- Instance
-- ---------------------------------------------------------------------

-- Enumerator#next
-- ---------------------------------------------------------------------

function Enumerator:next()
  return self.step()
end

-- Enumerator#peek
-- ---------------------------------------------------------------------

function Enumerator:peek()
  return self.step(true)
end

-- Enumerator#rewind
-- ---------------------------------------------------------------------

function Enumerator:rewind()
  self.step = self.newStepClosure()
end

-- ---------------------------------------------------------------------

return Enumerator
