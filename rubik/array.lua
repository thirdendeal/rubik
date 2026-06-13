-- Array
-- ---------------------------------------------------------------------

local class = require("middleclass")

local Object = require("rubik.object")

-- ---------------------------------------------------------------------

local Array = class("Array", Object)

-- ---------------------------------------------------------------------
-- Private
-- ---------------------------------------------------------------------

local _QUOTE_METHODS = { "empty?", "include?", "all?", "any?", "none?", "one?" }

-- ---------------------------------------------------------------------

local _wrapAroundIndex = function(t, index)
  return index > 0 and index or #t + index + 1
end

-- ---------------------------------------------------------------------
-- Class
-- ---------------------------------------------------------------------

-- Array::wrap
-- ---------------------------------------------------------------------

function Array.static.wrap(value)
  local array = Array:new()

  if type(value) == "table" then
    array:push(unpack(value))
  else
    array:push(value)
  end

  return array
end

-- Array::new
-- ---------------------------------------------------------------------

function Array:initialize(size, value, callback)
  self.__recipe = {}

  if callback then
    for i = 1, size or 0, 1 do
      table.insert(self.__recipe, callback(i))
    end
  elseif value ~= nil then -- Lua won't allow { nil, nil, ..., nil }
    for _ = 1, size or 0, 1 do
      table.insert(self.__recipe, value)
    end
  end

  self.class.rubik.patchQuoteMethods(self, _QUOTE_METHODS)
end

-- ---------------------------------------------------------------------
-- Instance
-- ---------------------------------------------------------------------

-- Array#first
-- ---------------------------------------------------------------------

function Array:first(n)
  if n then
    return self:slice(1, n)
  else
    return self.class.rubik(self.__recipe[1])
  end
end

-- Array#take alias

function Array:take(...)
  return self:first(...)
end

-- Array#last
-- ---------------------------------------------------------------------

function Array:last(n)
  if n then
    return self:slice({ #self.__recipe - n + 1, #self.__recipe })
  else
    return self.class.rubik(self.__recipe[#self.__recipe])
  end
end

-- Array#drop
-- ---------------------------------------------------------------------

function Array:drop(n)
  return self:slice({ 1, #self.__recipe - n })
end

-- Array#at
-- ---------------------------------------------------------------------

function Array:at(index)
  return self.class.rubik(self.__recipe[_wrapAroundIndex(self.__recipe, index)])
end

-- Array#fetch
-- ---------------------------------------------------------------------

function Array:fetch(index, fallback, callback)
  local element = self:at(index):unwrap()

  if element ~= nil then
    return self.class.rubik(element)
  else
    if callback then
      return self.class.rubik(callback(index))
    else
      return self.class.rubik(fallback)
    end
  end
end

-- Array#slice
-- ---------------------------------------------------------------------

function Array:slice(x, y)
  if type(x) == "table" then
    -- array:slice(range)

    local range = x

    if range[1] < 1 then
      range[1] = 1
    end

    if range[2] < 0 then
      range[2] = #self.__recipe + range[2] + 1
    end

    return self.class.rubik({ unpack(self.__recipe, range[1], range[2]) })
  elseif y == nil then
    -- array:slice(index)

    return self:at(x)
  else
    -- array:slice(start, length)

    local start, length = x, y

    return self.class.rubik({ unpack(self.__recipe, start, start + length - 1) })
  end
end

-- Array#size
-- ---------------------------------------------------------------------

function Array:size()
  return self.class.rubik(#self.__recipe)
end

-- Array#length alias

function Array:length()
  return self:size()
end

-- Array#count
-- ---------------------------------------------------------------------

function Array:count(element, callback)
  if element == nil and callback == nil then
    -- array:count()
    return self:size()
  else
    -- array:count(element)
    -- array:count(_, callback(element))

    callback = callback or function(value)
      return value == element
    end

    local count = 0

    for _, value in ipairs(self.__recipe) do
      if callback(value) then
        count = count + 1
      end
    end

    return self.class.rubik(count)
  end
end

-- Array#empty?
-- ---------------------------------------------------------------------

Array["empty?"] = function(self)
  return self.class.rubik(#self.__recipe == 0)
end

-- Array#include?
-- ---------------------------------------------------------------------

Array["include?"] = function(self, value)
  for _, element in ipairs(self.__recipe) do
    if element == value then
      return self.class.rubik(true)
    end
  end

  return self.class.rubik(false)
end

-- Array#push
-- ---------------------------------------------------------------------

function Array:push(...)
  self:insert(#self.__recipe + 1, ...)

  return self
end

-- Array#append alias

function Array:append(...)
  return self:push(...)
end

-- Array#unshift
-- ---------------------------------------------------------------------

function Array:unshift(...)
  self:insert(1, ...)

  return self
end

-- Array#prepend alias

function Array:prepend(...)
  return self:unshift(...)
end

-- Array#insert
-- ---------------------------------------------------------------------
--
-- Behavior does not change if `index` is negative, unlike Ruby

function Array:insert(index, ...)
  index = _wrapAroundIndex(self, index)

  for j, value in ipairs({ ... }) do
    local offset = j - 1

    table.insert(self.__recipe, index + offset, value)
  end

  return self
end

-- Array#pop
-- ---------------------------------------------------------------------

function Array:pop()
  return self.class.rubik(table.remove(self.__recipe, #self.__recipe))
end

-- Array#shift
-- ---------------------------------------------------------------------

function Array:shift()
  return self.class.rubik(table.remove(self.__recipe, 1))
end

-- Array#deleteAt
-- ---------------------------------------------------------------------

function Array:deleteAt(index)
  return self.class.rubik(table.remove(self.__recipe, _wrapAroundIndex(self.__recipe, index)))
end

-- Array#delete
-- ---------------------------------------------------------------------

function Array:delete(value)
  local removal = {}

  for i, element in ipairs(self.__recipe) do
    if element == value then
      table.insert(removal, i)
    end
  end

  for j, position in ipairs(removal) do
    local offset = j - 1

    self:deleteAt(position - offset)
  end

  return self.class.rubik(#removal ~= 0 and value or nil)
end

-- Array#uniq
-- ---------------------------------------------------------------------

function Array:uniq(callback)
  local hash = {}

  callback = callback or function(element)
    return element
  end

  for _, element in ipairs(self.__recipe) do
    if not hash[callback(element)] then
      hash[callback(element)] = element
    end
  end

  local newArray = {}

  for _, value in pairs(hash) do
    table.insert(newArray, value)
  end

  return self.class.rubik(newArray)
end

-- Array#each
-- ---------------------------------------------------------------------

function Array:each(callback)
  for _, element in ipairs(self.__recipe) do
    callback(element)
  end

  return self
end

-- Array#reverseEach
-- ---------------------------------------------------------------------

function Array:reverseEach(callback)
  for i = #self.__recipe, 1, -1 do
    callback(self.__recipe[i])
  end

  return self
end

-- Array#eachIndex
-- ---------------------------------------------------------------------

function Array:eachIndex(callback)
  for index, _ in ipairs(self.__recipe) do
    callback(index)
  end

  return self
end

-- Array#map
-- ---------------------------------------------------------------------

function Array:map(callback)
  local newArray = {}

  for _, element in ipairs(self.__recipe) do
    table.insert(newArray, callback(element))
  end

  return self.class.rubik(newArray)
end

-- Array#collect alias

function Array:collect(...)
  return self:map(...)
end

-- Array#select
-- ---------------------------------------------------------------------

function Array:select(callback)
  local newArray = {}

  for _, element in ipairs(self.__recipe) do
    if callback(element) then
      table.insert(newArray, element)
    end
  end

  return self.class.rubik(newArray)
end

-- Array#filter alias

function Array:filter(...)
  return self:select(...)
end

-- Array#keepIf
-- ---------------------------------------------------------------------

function Array:keepIf(callback)
  local removal = {}

  for i, _ in ipairs(self.__recipe) do
    if not callback(self.__recipe[i]) then
      table.insert(removal, i)
    end
  end

  for j, position in ipairs(removal) do
    local offset = j - 1

    self:deleteAt(position - offset)
  end

  return self
end

-- Array#reject
-- ---------------------------------------------------------------------

function Array:reject(callback)
  local newArray = {}

  for _, element in ipairs(self.__recipe) do
    if not callback(element) then
      table.insert(newArray, element)
    end
  end

  return self.class.rubik(newArray)
end

-- Array#deleteIf
-- ---------------------------------------------------------------------

function Array:deleteIf(callback)
  local removal = {}

  for i, _ in ipairs(self.__recipe) do
    if callback(self.__recipe[i]) then
      table.insert(removal, i)
    end
  end

  for j, position in ipairs(removal) do
    local offset = j - 1

    self:deleteAt(position - offset)
  end

  return self
end

-- Array#all?
-- ---------------------------------------------------------------------

Array["all?"] = function(self, value, callback)
  for _, element in ipairs(self.__recipe) do
    -- array[":all?"](_, callback)

    if callback ~= nil then
      if not callback(element) then
        return self.class.rubik(false)
      end
    elseif value ~= nil then
      -- array[":all?"](value)

      if element ~= value then
        return self.class.rubik(false)
      end
    else
      -- array[":all?"]()

      if not element then
        return self.class.rubik(false)
      end
    end
  end

  return self.class.rubik(true)
end

-- Array#any?
-- ---------------------------------------------------------------------

Array["any?"] = function(self, value, callback)
  for _, element in ipairs(self.__recipe) do
    -- array[":any?"](_, callback)

    if callback ~= nil then
      if callback(element) then
        return self.class.rubik(true)
      end
    elseif value ~= nil then
      -- array[":any?"](value)

      if element == value then
        return self.class.rubik(true)
      end
    else
      -- array[":any?"]()

      if element then
        return self.class.rubik(true)
      end
    end
  end

  return self.class.rubik(false)
end

-- Array#none?
-- ---------------------------------------------------------------------

Array["none?"] = function(self, value, callback)
  for _, element in ipairs(self.__recipe) do
    -- array[":none?"](_, callback)

    if callback ~= nil then
      if callback(element) then
        return self.class.rubik(false)
      end
    elseif value ~= nil then
      -- array[":none?"](value)

      if element == value then
        return self.class.rubik(false)
      end
    else
      -- array[":none?"]()

      if element then
        return self.class.rubik(false)
      end
    end
  end

  return self.class.rubik(true)
end

-- Array#one?
-- ---------------------------------------------------------------------

Array["one?"] = function(self, value, callback)
  local found = false

  for _, element in ipairs(self.__recipe) do
    -- array[":one?"](_, callback)

    if callback ~= nil then
      if callback(element) then
        if found then
          return self.class.rubik(false)
        else
          found = true
        end
      end
    elseif value ~= nil then
      -- array[":one?"](value)

      if element == value then
        if found then
          return self.class.rubik(false)
        else
          found = true
        end
      end
    else
      -- array[":one?"]()

      if element then
        if found then
          return self.class.rubik(false)
        else
          found = true
        end
      end
    end
  end

  return self.class.rubik(found)
end

-- Array#index
-- ---------------------------------------------------------------------

function Array:index(value, callback)
  for index, element in ipairs(self.__recipe) do
    if callback ~= nil then
      -- array:index(_, callback)

      if callback(element) then
        return self.class.rubik(index)
      end
    elseif value ~= nil then
      -- array:index(value)

      if element == value then
        return self.class.rubik(index)
      end
    end
  end

  return self.class.rubik(nil)
end

-- Array#findIndex alias

function Array:findIndex(...)
  return self:index(...)
end

-- Array#rindex
-- ---------------------------------------------------------------------

function Array:rindex(value, callback)
  for index = #self.__recipe, 1, -1 do
    local element = self.__recipe[index]

    if callback ~= nil then
      -- array:index(_, callback)

      if callback(element) then
        return self.class.rubik(index)
      end
    elseif value ~= nil then
      -- array:index(value)

      if element == value then
        return self.class.rubik(index)
      end
    end
  end

  return self.class.rubik(nil)
end

-- Array#minmax
-- ---------------------------------------------------------------------

function Array:minmax(callback)
  local minimum = self.__recipe[1]
  local maximum = self.__recipe[1]

  callback = callback or self.class.rubik["<=>"]

  for _, value in ipairs(self.__recipe) do
    if callback(value, maximum) == 1 then
      maximum = value
    elseif callback(value, minimum) == -1 then
      minimum = value
    end
  end

  return self.class.rubik({ minimum, maximum })
end

-- Array#sort
-- ---------------------------------------------------------------------

function Array:sort(callback)
  local copyArray = { unpack(self.__recipe) }

  table.sort(copyArray, callback or function(a, b)
    return a < b
  end)

  return self.class.rubik(copyArray)
end

-- Array#reverse
-- ---------------------------------------------------------------------

function Array:reverse()
  local copyArray = { unpack(self.__recipe) }
  local size = #copyArray

  for i = 1, math.floor(size / 2), 1 do
    local opposite = size - i + 1

    copyArray[i], copyArray[opposite] = copyArray[opposite], copyArray[i]
  end

  return self.class.rubik(copyArray)
end

-- Array#max
-- ---------------------------------------------------------------------

function Array:max(n, callback)
  local sorted = self:sort(callback)

  if type(n) == "number" then
    return sorted:last(n):reverse()
  else
    return sorted:last()
  end
end

-- Array#min
-- ---------------------------------------------------------------------

function Array:min(n, callback)
  local sorted = self:sort(callback)

  if type(n) == "number" then
    return sorted:first(n)
  else
    return sorted:first()
  end
end

-- Array#assoc
-- ---------------------------------------------------------------------

function Array:assoc(value)
  for _, element in ipairs(self.__recipe) do
    if type(element) == "table" then
      if element[1] == value then
        return self.class.rubik(element)
      end
    end
  end

  return self.class.rubik(nil)
end

-- Array#rassoc
-- ---------------------------------------------------------------------

function Array:rassoc(value)
  for _, element in ipairs(self.__recipe) do
    if type(element) == "table" then
      if element[2] == value then
        return self.class.rubik(element)
      end
    end
  end

  return self.class.rubik(nil)
end

-- Array#valuesAt
-- ---------------------------------------------------------------------

function Array:valuesAt(...)
  local elements = {}

  for _, position in ipairs({ ... }) do -- each argument may be either an index or a range
    local foundElements = self.class.rubik.Kernel.Array(self:slice(position))

    for _, element in ipairs(foundElements:unwrap()) do
      table.insert(elements, element)
    end
  end

  return self.class.rubik(elements)
end

-- Array#dig
-- ---------------------------------------------------------------------

function Array:dig(...)
  local reached = self.__recipe

  for _, index in ipairs({ ... }) do
    reached = self.class.rubik.at(reached, index)
  end

  return self.class.rubik(reached)
end

-- Array#shuffle
-- ---------------------------------------------------------------------

function Array:shuffle(prng)
  local indices = Array:new(#self.__recipe, _, function(index)
    return index
  end)

  local shuffled = {}

  prng = prng or function(max)
    return math.random(max)
  end

  for max = indices:size():unwrap(), 1, -1 do
    local index = indices:deleteAt(prng(max)):unwrap()

    table.insert(shuffled, self.__recipe[index])
  end

  return self.class.rubik(shuffled)
end

-- Array#sample
-- ---------------------------------------------------------------------

function Array:sample(n, prng)
  if n then
    return self:shuffle(prng):first(n)
  else
    return self:shuffle(prng):first()
  end
end

-- Array#cycle
-- ---------------------------------------------------------------------

function Array:cycle(count, callback)
  if count then
    for _ = 1, count, 1 do
      self:each(callback)
    end
  else
    while true do
      self:each(callback)
    end
  end

  return self.class.rubik(nil)
end

-- ---------------------------------------------------------------------

return Array
