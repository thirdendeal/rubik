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
    return rubik.slice(array, 1, n)
  else
    return array[1]
  end
end

-- Array#last
-- ---------------------------------------------------------------------

function rubik.last(array, n)
  if n then
    return rubik.slice(array, { #array - n + 1, #array })
  else
    return array[#array]
  end
end

-- Array#take
-- ---------------------------------------------------------------------

function rubik.take(array, n)
  return rubik.first(array, n)
end

-- Array#drop
-- ---------------------------------------------------------------------

function rubik.drop(array, n)
  return rubik.slice(array, { 1, #array - n })
end

-- Array#at
-- ---------------------------------------------------------------------

function rubik.at(array, index)
  if index > 0 then
    return array[index]
  else
    return array[#array + index + 1]
  end
end

-- Array#fetch
-- ---------------------------------------------------------------------

function rubik.fetch(array, index, fallback, callback)
  local element = rubik.at(array, index)

  if element ~= nil then
    return element
  else
    if callback then
      return callback(index)
    else
      return fallback
    end
  end
end

-- Array#slice
-- ---------------------------------------------------------------------

function rubik.slice(array, x, y)
  if type(x) == "table" then
    -- rubik.slice(array, range)

    local range = x

    if range[1] < 1 then
      range[1] = 1
    end

    if range[2] < 0 then
      range[2] = #array + range[2] + 1
    end

    return { unpack(array, range[1], range[2]) }
  elseif y == nil then
    -- rubik.slice(array, index)

    return rubik.at(array, x)
  else
    -- rubik.slice(array, start, length)

    local start, length = x, y

    return { unpack(array, start, start + length - 1) }
  end
end

-- Array#size
-- ---------------------------------------------------------------------

function rubik.size(array)
  return #array
end

-- Array#length
-- ---------------------------------------------------------------------

function rubik.length(array)
  return rubik.size(array)
end

-- Array#count
-- ---------------------------------------------------------------------

function rubik.count(array, element, callback)
  if element == nil and callback == nil then
    -- rubik.count(array)
    return rubik.size(array)
  else
    -- rubik.count(array, element)
    -- rubik.count(array, _, callback(element))

    callback = callback or function(value)
      return value == element
    end

    local count = 0

    for _, value in ipairs(array) do
      if callback(value) then
        count = count + 1
      end
    end

    return count
  end
end

-- Array#isEmpty
-- ---------------------------------------------------------------------

function rubik.isEmpty(array)
  return rubik.size(array) == 0
end

-- ---------------------------------------------------------------------

return rubik
