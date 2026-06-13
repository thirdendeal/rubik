-- Kernel
-- ---------------------------------------------------------------------

local class = require("middleclass")

-- ---------------------------------------------------------------------

local Kernel = class("Kernel")

-- Kernel::Array
-- ---------------------------------------------------------------------

function Kernel.static.Array(recipe)
  if type(recipe) == "table" then
    if recipe.__recipe then
      recipe = recipe.__recipe
    end

    return Kernel.rubik.Array.wrap(recipe)
  else
    return Kernel.rubik.Array.wrap({ recipe })
  end
end

-- ---------------------------------------------------------------------

return Kernel
