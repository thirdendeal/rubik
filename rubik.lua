-- Rubik
-- ---------------------------------------------------------------------

local rubik = { _version = "0.0.0" }

-- (Proof of concept)
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

rubik.each = function(t, callback, ...)
  local iterator = rubik._each(t)

  if callback then
    for _, value in iterator(t) do
      callback(value, ...)
    end
  end

  return t
end

-- ---------------------------------------------------------------------
-- Array
-- ---------------------------------------------------------------------

-- Array#new (newArray)
-- ---------------------------------------------------------------------

function rubik.newArray(size, value, callback)
  local array = {}

  if callback then
    for i = 1, size or 0, 1 do
      table.insert(array, callback(i))
    end
  elseif value ~= nil then -- [nil, nil, ..., nil] == {}
    for _ = 1, size or 0, 1 do
      table.insert(array, value)
    end
  end

  return array
end

-- Array#first
-- ---------------------------------------------------------------------

function rubik.first(array, n)
  if n then
    local newArray = {}

    for i = 1, n, 1 do
      table.insert(newArray, array[i])
    end

    return newArray
  else
    return array[1]
  end
end

-- Array#last
-- ---------------------------------------------------------------------

function rubik.last(array, n)
  if n then
    local newArray = {}

    for i = 1 + #array - n, #array, 1 do
      table.insert(newArray, array[i])
    end

    return newArray
  else
    return array[#array]
  end
end

-- ---------------------------------------------------------------------

return rubik
