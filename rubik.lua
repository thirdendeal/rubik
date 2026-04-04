-- Rubik
-- ---------------------------------------------------------------------

local rubik = {
  _version = "0.0.0"
}

-- ---------------------------------------------------------------------

function rubik._each(value)
  if type(value) == "table" then
    if value[1] ~= nil then
      return ipairs
    else
      return pairs
    end
  else
    error("Expected a table", 3)
  end
end

-- ---------------------------------------------------------------------

rubik.each = function(t, callback, ...)
  local iterator = rubik._each(t)

  for _, value in iterator(t) do
    callback(value, ...)
  end

  return t
end

-- ---------------------------------------------------------------------

return rubik
