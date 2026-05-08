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

-- ---------------------------------------------------------------------`

function rubik._mirrorIndex(array, index)
  return index > 0 and index or #array + index + 1
end

function rubik._spaceshipOperator(a, b) -- <=>
  -- Three-Way Comparison

  if type(a) ~= "number" or type(b) ~= "number" then
    return
  end

  if a > b then
    return 1
  elseif a == b then
    return 0
  else -- a < b
    return -1
  end
end

-- ---------------------------------------------------------------------
-- Array
-- ---------------------------------------------------------------------

-- Array#newArray
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
  return array[rubik._mirrorIndex(array, index)]
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
  return #array
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

-- Array#empty?
-- ---------------------------------------------------------------------

rubik["empty?"] = function(array)
  return #array == 0
end

-- Array#include?
-- ---------------------------------------------------------------------

rubik["include?"] = function(array, value)
  for _, element in ipairs(array) do
    if element == value then
      return true
    end
  end

  return false
end

-- Array#push
-- ---------------------------------------------------------------------

function rubik.push(array, ...)
  rubik.insert(array, #array + 1, ...)

  return array
end

-- Array#append alias

function rubik.append(array, ...)
  return rubik.push(array, ...)
end

-- Array#unshift
-- ---------------------------------------------------------------------

function rubik.unshift(array, ...)
  rubik.insert(array, 1, ...)

  return array
end

-- Array#prepend alias

function rubik.prepend(array, ...)
  return rubik.unshift(array, ...)
end

-- Array#insert
-- ---------------------------------------------------------------------
--
-- Behavior does not change if `index` is negative, unlike Ruby

function rubik.insert(array, index, ...)
  index = rubik._mirrorIndex(array, index)

  for j, value in ipairs({ ... }) do
    local offset = j - 1

    table.insert(array, index + offset, value)
  end

  return array
end

-- Array#pop
-- ---------------------------------------------------------------------

function rubik.pop(array)
  return table.remove(array, #array)
end

-- Array#shift
-- ---------------------------------------------------------------------

function rubik.shift(array)
  return table.remove(array, 1)
end

-- Array#deleteAt
-- ---------------------------------------------------------------------

function rubik.deleteAt(array, index)
  return table.remove(array, rubik._mirrorIndex(array, index))
end

-- Array#delete
-- ---------------------------------------------------------------------

function rubik.delete(array, value)
  local removal = {}

  for i, element in ipairs(array) do
    if element == value then
      rubik.push(removal, i)
    end
  end

  for j, position in ipairs(removal) do
    local offset = j - 1

    rubik.deleteAt(array, position - offset)
  end

  if #removal ~= 0 then
    return value
  end
end

-- Array#uniq
-- ---------------------------------------------------------------------

function rubik.uniq(array, callback)
  local hash = {}

  callback = callback or function(element)
    return element
  end

  for _, element in ipairs(array) do
    if not hash[callback(element)] then
      hash[callback(element)] = element
    end
  end

  local newArray = {}

  for _, value in pairs(hash) do
    rubik.push(newArray, value)
  end

  return newArray
end

-- Array#each
-- ---------------------------------------------------------------------
--
-- TODO: rubik.each(array) -> Enumerator

function rubik.each(array, callback)
  for _, value in ipairs(array) do
    callback(value)
  end

  return array
end

-- Array#reverseEach
-- ---------------------------------------------------------------------
--
-- TODO: rubik.reverseEach(array) -> Enumerator

function rubik.reverseEach(array, callback)
  for i = #array, 1, -1 do
    callback(array[i])
  end

  return array
end

-- Array#eachIndex
-- ---------------------------------------------------------------------
--
-- TODO: rubik.eachIndex(array) -> Enumerator

function rubik.eachIndex(array, callback)
  for index, _ in ipairs(array) do
    callback(index)
  end

  return array
end

-- Array#map
-- ---------------------------------------------------------------------
--
-- TODO: rubik.map(array) -> Enumerator

function rubik.map(array, callback)
  local newArray = {}

  for _, element in ipairs(array) do
    rubik.push(newArray, callback(element))
  end

  return newArray
end

-- Array#collect alias

function rubik.collect(array, callback)
  return rubik.map(array, callback)
end

-- Array#select
-- ---------------------------------------------------------------------
--
-- TODO: rubik.select(array) -> Enumerator

function rubik.select(array, callback)
  local newArray = {}

  for _, element in ipairs(array) do
    if callback(element) then
      rubik.push(newArray, element)
    end
  end

  return newArray
end

-- Array#filter alias

function rubik.filter(array, callback)
  return rubik.select(array, callback)
end

-- Array#keepIf
-- ---------------------------------------------------------------------
--
-- TODO: rubik.keepIf(array) -> Enumerator

function rubik.keepIf(array, callback)
  local removal = {}

  for i, _ in ipairs(array) do
    if not callback(array[i]) then
      rubik.push(removal, i)
    end
  end

  for j, position in ipairs(removal) do
    local offset = j - 1

    rubik.deleteAt(array, position - offset)
  end

  return array
end

-- Array#reject
-- ---------------------------------------------------------------------
--
-- TODO: rubik.reject(array) -> Enumerator

function rubik.reject(array, callback)
  local newArray = {}

  for _, element in ipairs(array) do
    if not callback(element) then
      rubik.push(newArray, element)
    end
  end

  return newArray
end

-- Array#deleteIf
-- ---------------------------------------------------------------------
--
-- TODO: rubik.deleteIf(array) -> Enumerator

function rubik.deleteIf(array, callback)
  local removal = {}

  for i, _ in ipairs(array) do
    if callback(array[i]) then
      rubik.push(removal, i)
    end
  end

  for j, position in ipairs(removal) do
    local offset = j - 1

    rubik.deleteAt(array, position - offset)
  end

  return array
end

-- Array#all?
-- ---------------------------------------------------------------------

rubik["all?"] = function(array, value, callback)
  for _, element in ipairs(array) do
    -- rubik["all?"](array, _, callback)

    if callback ~= nil then
      if not callback(element) then
        return false
      end
    elseif value ~= nil then
      -- rubik["all?"](array, value)

      if element ~= value then
        return false
      end
    else
      -- rubik["all?"](array)

      if not element then
        return false
      end
    end
  end

  return true
end

-- Array#any?
-- ---------------------------------------------------------------------

rubik["any?"] = function(array, value, callback)
  for _, element in ipairs(array) do
    -- rubik["any?"](array, _, callback)

    if callback ~= nil then
      if callback(element) then
        return true
      end
    elseif value ~= nil then
      -- rubik["any?"](array, value)

      if element == value then
        return true
      end
    else
      -- rubik["any?"](array)

      if element then
        return true
      end
    end
  end

  return false
end

-- Array#none?
-- ---------------------------------------------------------------------

rubik["none?"] = function(array, value, callback)
  for _, element in ipairs(array) do
    -- rubik["none?"](array, _, callback)

    if callback ~= nil then
      if callback(element) then
        return false
      end
    elseif value ~= nil then
      -- rubik["none?"](array, value)

      if element == value then
        return false
      end
    else
      -- rubik["none?"](array)

      if element then
        return false
      end
    end
  end

  return true
end

-- Array#one?
-- ---------------------------------------------------------------------

rubik["one?"] = function(array, value, callback)
  local found = false

  for _, element in ipairs(array) do
    -- rubik["one?"](array, _, callback)

    if callback ~= nil then
      if callback(element) then
        if found then
          return false
        else
          found = true
        end
      end
    elseif value ~= nil then
      -- rubik["one?"](array, value)

      if element == value then
        if found then
          return false
        else
          found = true
        end
      end
    else
      -- rubik["one?"](array)

      if element then
        if found then
          return false
        else
          found = true
        end
      end
    end
  end

  return found
end

-- Array#index
-- ---------------------------------------------------------------------
--
-- TODO: rubik.index(array) -> Enumerator

function rubik.index(array, value, callback)
  for index, element in ipairs(array) do
    if callback ~= nil then
      -- rubik.index(array, _, callback)

      if callback(element) then
        return index
      end
    elseif value ~= nil then
      -- rubik.index(array, value)

      if element == value then
        return index
      end
    end
  end
end

-- Array#findIndex alias

function rubik.findIndex(array, value, callback)
  return rubik.index(array, value, callback)
end

-- Array#rindex
-- ---------------------------------------------------------------------
--
-- TODO: rubik.rindex(array) -> Enumerator

function rubik.rindex(array, value, callback)
  for index = #array, 1, -1 do
    local element = array[index]

    if callback ~= nil then
      -- rubik.index(array, _, callback)

      if callback(element) then
        return index
      end
    elseif value ~= nil then
      -- rubik.index(array, value)

      if element == value then
        return index
      end
    end
  end
end

-- Array#minmax
-- ---------------------------------------------------------------------

function rubik.minmax(array, callback)
  local minimum = array[1]
  local maximum = array[1]

  callback = callback or rubik._spaceshipOperator

  for _, value in ipairs(array) do
    if callback(value, maximum) == 1 then
      maximum = value
    elseif callback(value, minimum) == -1 then
      minimum = value
    end
  end

  return { minimum, maximum }
end

-- Array#sort
-- ---------------------------------------------------------------------

function rubik.sort(array, callback)
  local copy = { unpack(array) }

  table.sort(copy, callback or function(a, b)
    return a < b
  end)

  return copy
end

-- Array#reverse
-- ---------------------------------------------------------------------

function rubik.reverse(array)
  local copy = { unpack(array) }
  local size = #copy

  for i = 1, math.floor(size / 2), 1 do
    local opposite = size - i + 1

    copy[i], copy[opposite] = copy[opposite], copy[i]
  end

  return copy
end

-- Array#max
-- ---------------------------------------------------------------------

function rubik.max(array, n, callback)
  local sorted = rubik.sort(array, callback)

  if type(n) == "number" then
    return rubik.reverse(rubik.last(sorted, n))
  else
    return rubik.last(sorted)
  end
end

-- Array#min
-- ---------------------------------------------------------------------

function rubik.min(array, n, callback)
  local sorted = rubik.sort(array, callback)

  if type(n) == "number" then
    return rubik.first(sorted, n)
  else
    return rubik.first(sorted)
  end
end

-- ---------------------------------------------------------------------

return rubik
