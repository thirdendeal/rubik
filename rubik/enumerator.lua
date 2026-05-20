-- Enumerator
-- ---------------------------------------------------------------------

local class = require("middleclass")

-- ---------------------------------------------------------------------

local Enumerator = class('Enumerator')

-- Enumerator#new
-- ---------------------------------------------------------------------

function Enumerator:initialize(x, y)
  if y then
    self.size, self.newStepClosure = x, y
  else
    self.newStepClosure = x
  end

  self.step = self.newStepClosure()
end

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
