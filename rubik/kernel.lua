-- Kernel
-- ---------------------------------------------------------------------

local class = require("middleclass")

-- ---------------------------------------------------------------------

local Kernel = class("Kernel")

-- ---------------------------------------------------------------------
-- Class
-- ---------------------------------------------------------------------

-- Kernel::Array
-- ---------------------------------------------------------------------

function Kernel.static.Array(recipe)
  if type(recipe) == "table" then
    if recipe.__lua then
      recipe = recipe.__lua
    end

    return Kernel.rubik.Array.fromLiteral(recipe)
  else
    return Kernel.rubik.Array.fromLiteral({ recipe })
  end
end

-- ---------------------------------------------------------------------

return Kernel
