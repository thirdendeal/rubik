-- Array
-- ---------------------------------------------------------------------

local class = require("middleclass")
local inspect = require("inspect")

local Object = require("rubik.basic-object.object")

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

-- Array::new (Rubik + Ruby)
-- ---------------------------------------------------------------------

function Array:initialize(size, value, block)
  self.__lua = {}
  Array.rubik.patch_quote_methods(self, _QUOTE_METHODS)

  if block then
    for index = 1, size or 0, 1 do
      table.insert(self.__lua, block(index))
    end
  elseif value ~= nil then -- Lua won't allow { nil, nil, ..., nil }
    for _ = 1, size or 0, 1 do
      table.insert(self.__lua, value)
    end
  end
end

-- Array::fromLiteral

function Array.static.fromLiteral(t)
  return Array:new():push(unpack(t))
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
    return Array.rubik(self.__lua[1])
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
    return self:slice({ #self.__lua - n + 1, #self.__lua })
  else
    return Array.rubik(self.__lua[#self.__lua])
  end
end

-- Array#drop
-- ---------------------------------------------------------------------

function Array:drop(n)
  return self:slice({ 1, #self.__lua - n })
end

-- Array#at
-- ---------------------------------------------------------------------

function Array:at(index)
  return Array.rubik(self.__lua[_wrapAroundIndex(self.__lua, index)])
end

-- Array#__index metamethod

function Array:__index(index)
  return self:at(index)
end

-- Array#fetch
-- ---------------------------------------------------------------------

function Array:fetch(index, fallback, block)
  local element = self:at(index):derubik()

  if element ~= nil then
    return Array.rubik(element)
  else
    if block then
      return Array.rubik(block(index))
    else
      return Array.rubik(fallback)
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
      range[2] = #self.__lua + range[2] + 1
    end

    return Array.rubik({ unpack(self.__lua, range[1], range[2]) })
  elseif y == nil then
    -- array:slice(index)

    return self:at(x)
  else
    -- array:slice(start, length)

    local start, length = x, y

    return Array.rubik({ unpack(self.__lua, start, start + length - 1) })
  end
end

-- Array#size
-- ---------------------------------------------------------------------

function Array:size()
  return Array.rubik(#self.__lua)
end

-- Array#length alias

function Array:length()
  return self:size()
end

-- Array#count
-- ---------------------------------------------------------------------

function Array:count(element, block)
  if element == nil and block == nil then
    -- array:count()
    return self:size()
  else
    -- array:count(element)
    -- array:count(_, block(element))

    block = block or function(value)
      return value == element
    end

    local count = 0

    for _, value in ipairs(self.__lua) do
      if block(value) then
        count = count + 1
      end
    end

    return Array.rubik(count)
  end
end

-- Array#empty?
-- ---------------------------------------------------------------------

Array["empty?"] = function(self)
  return Array.rubik(#self.__lua == 0)
end

-- Array#include?
-- ---------------------------------------------------------------------

Array["include?"] = function(self, value)
  for _, element in ipairs(self.__lua) do
    if element == value then
      return Array.rubik(true)
    end
  end

  return Array.rubik(false)
end

-- Array#push
-- ---------------------------------------------------------------------

function Array:push(...)
  self:insert(#self.__lua + 1, ...)

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

    table.insert(self.__lua, index + offset, value)
  end

  return self
end

-- Array#pop
-- ---------------------------------------------------------------------

function Array:pop()
  return Array.rubik(table.remove(self.__lua, #self.__lua))
end

-- Array#shift
-- ---------------------------------------------------------------------

function Array:shift()
  return Array.rubik(table.remove(self.__lua, 1))
end

-- Array#delete_at
-- ---------------------------------------------------------------------

function Array:delete_at(index)
  return Array.rubik(table.remove(self.__lua, _wrapAroundIndex(self.__lua, index)))
end

-- Array#delete
-- ---------------------------------------------------------------------

function Array:delete(value)
  local removal = {}

  for i, element in ipairs(self.__lua) do
    if element == value then
      table.insert(removal, i)
    end
  end

  for j, position in ipairs(removal) do
    local offset = j - 1

    self:delete_at(position - offset)
  end

  return Array.rubik(#removal ~= 0 and value or nil)
end

-- Array#uniq
-- ---------------------------------------------------------------------

function Array:uniq(block)
  local hash = {}

  block = block or function(element)
    return element
  end

  for _, element in ipairs(self.__lua) do
    if not hash[block(element)] then
      hash[block(element)] = element
    end
  end

  local newArray = {}

  for _, value in pairs(hash) do
    table.insert(newArray, value)
  end

  return Array.rubik(newArray)
end

-- Array#each
-- ---------------------------------------------------------------------

function Array:each(block)
  for _, element in ipairs(self.__lua) do
    block(element)
  end

  return self
end

-- Array#reverse_each
-- ---------------------------------------------------------------------

function Array:reverse_each(block)
  for index = #self.__lua, 1, -1 do
    local element = self.__lua[index]

    block(element)
  end

  return self
end

-- Array#each_index
-- ---------------------------------------------------------------------

function Array:each_index(block)
  for index, _ in ipairs(self.__lua) do
    block(index)
  end

  return self
end

-- Array#map
-- ---------------------------------------------------------------------

function Array:map(block)
  local newArray = {}

  for _, element in ipairs(self.__lua) do
    table.insert(newArray, block(element))
  end

  return Array.rubik(newArray)
end

-- Array#collect alias

function Array:collect(...)
  return self:map(...)
end

-- Array#select
-- ---------------------------------------------------------------------

function Array:select(block)
  local newArray = {}

  for _, element in ipairs(self.__lua) do
    if block(element) then
      table.insert(newArray, element)
    end
  end

  return Array.rubik(newArray)
end

-- Array#filter alias

function Array:filter(...)
  return self:select(...)
end

-- Array#keep_if
-- ---------------------------------------------------------------------

function Array:keep_if(block)
  local removal = {}

  for i, _ in ipairs(self.__lua) do
    if not block(self.__lua[i]) then
      table.insert(removal, i)
    end
  end

  for j, position in ipairs(removal) do
    local offset = j - 1

    self:delete_at(position - offset)
  end

  return self
end

-- Array#reject
-- ---------------------------------------------------------------------

function Array:reject(block)
  local newArray = {}

  for _, element in ipairs(self.__lua) do
    if not block(element) then
      table.insert(newArray, element)
    end
  end

  return Array.rubik(newArray)
end

-- Array#delete_if
-- ---------------------------------------------------------------------

function Array:delete_if(block)
  local removal = {}

  for i, _ in ipairs(self.__lua) do
    if block(self.__lua[i]) then
      table.insert(removal, i)
    end
  end

  for j, position in ipairs(removal) do
    local offset = j - 1

    self:delete_at(position - offset)
  end

  return self
end

-- Array#all?
-- ---------------------------------------------------------------------

Array["all?"] = function(self, value, block)
  for _, element in ipairs(self.__lua) do
    -- array[":all?"](_, block)

    if block ~= nil then
      if not block(element) then
        return Array.rubik(false)
      end
    elseif value ~= nil then
      -- array[":all?"](value)

      if element ~= value then
        return Array.rubik(false)
      end
    else
      -- array[":all?"]()

      if not element then
        return Array.rubik(false)
      end
    end
  end

  return Array.rubik(true)
end

-- Array#any?
-- ---------------------------------------------------------------------

Array["any?"] = function(self, value, block)
  for _, element in ipairs(self.__lua) do
    -- array[":any?"](_, block)

    if block ~= nil then
      if block(element) then
        return Array.rubik(true)
      end
    elseif value ~= nil then
      -- array[":any?"](value)

      if element == value then
        return Array.rubik(true)
      end
    else
      -- array[":any?"]()

      if element then
        return Array.rubik(true)
      end
    end
  end

  return Array.rubik(false)
end

-- Array#none?
-- ---------------------------------------------------------------------

Array["none?"] = function(self, value, block)
  for _, element in ipairs(self.__lua) do
    -- array[":none?"](_, block)

    if block ~= nil then
      if block(element) then
        return Array.rubik(false)
      end
    elseif value ~= nil then
      -- array[":none?"](value)

      if element == value then
        return Array.rubik(false)
      end
    else
      -- array[":none?"]()

      if element then
        return Array.rubik(false)
      end
    end
  end

  return Array.rubik(true)
end

-- Array#one?
-- ---------------------------------------------------------------------

Array["one?"] = function(self, value, block)
  local found = false

  for _, element in ipairs(self.__lua) do
    -- array[":one?"](_, block)

    if block ~= nil then
      if block(element) then
        if found then
          return Array.rubik(false)
        else
          found = true
        end
      end
    elseif value ~= nil then
      -- array[":one?"](value)

      if element == value then
        if found then
          return Array.rubik(false)
        else
          found = true
        end
      end
    else
      -- array[":one?"]()

      if element then
        if found then
          return Array.rubik(false)
        else
          found = true
        end
      end
    end
  end

  return Array.rubik(found)
end

-- Array#index
-- ---------------------------------------------------------------------

function Array:index(value, block)
  for index, element in ipairs(self.__lua) do
    if block ~= nil then
      -- array:index(_, block)

      if block(element) then
        return Array.rubik(index)
      end
    elseif value ~= nil then
      -- array:index(value)

      if element == value then
        return Array.rubik(index)
      end
    end
  end

  return Array.rubik(nil)
end

-- Array#find_index alias

function Array:find_index(...)
  return self:index(...)
end

-- Array#rindex
-- ---------------------------------------------------------------------

function Array:rindex(value, block)
  for index = #self.__lua, 1, -1 do
    local element = self.__lua[index]

    if block ~= nil then
      -- array:index(_, block)

      if block(element) then
        return Array.rubik(index)
      end
    elseif value ~= nil then
      -- array:index(value)

      if element == value then
        return Array.rubik(index)
      end
    end
  end

  return Array.rubik(nil)
end

-- Array#minmax
-- ---------------------------------------------------------------------

function Array:minmax(block)
  local minimum = self.__lua[1]
  local maximum = self.__lua[1]

  block = block or Array.rubik["<=>"]

  for _, value in ipairs(self.__lua) do
    if block(value, maximum) == 1 then
      maximum = value
    elseif block(value, minimum) == -1 then
      minimum = value
    end
  end

  return Array.rubik({ minimum, maximum })
end

-- Array#sort
-- ---------------------------------------------------------------------

function Array:sort(block)
  local copyArray = { unpack(self.__lua) }

  table.sort(copyArray, block or function(a, b)
    return a < b
  end)

  return Array.rubik(copyArray)
end

-- Array#reverse
-- ---------------------------------------------------------------------

function Array:reverse()
  local copyArray = { unpack(self.__lua) }
  local size = #copyArray

  for i = 1, math.floor(size / 2), 1 do
    local opposite = size - i + 1

    copyArray[i], copyArray[opposite] = copyArray[opposite], copyArray[i]
  end

  return Array.rubik(copyArray)
end

-- Array#max
-- ---------------------------------------------------------------------

function Array:max(n, block)
  local sorted = self:sort(block)

  if type(n) == "number" then
    return sorted:last(n):reverse()
  else
    return sorted:last()
  end
end

-- Array#min
-- ---------------------------------------------------------------------

function Array:min(n, block)
  local sorted = self:sort(block)

  if type(n) == "number" then
    return sorted:first(n)
  else
    return sorted:first()
  end
end

-- Array#assoc
-- ---------------------------------------------------------------------

function Array:assoc(value)
  for _, element in ipairs(self.__lua) do
    if type(element) == "table" then
      if element[1] == value then
        return Array.rubik(element)
      end
    end
  end

  return Array.rubik(nil)
end

-- Array#rassoc
-- ---------------------------------------------------------------------

function Array:rassoc(value)
  for _, element in ipairs(self.__lua) do
    if type(element) == "table" then
      if element[2] == value then
        return Array.rubik(element)
      end
    end
  end

  return Array.rubik(nil)
end

-- Array#values_at
-- ---------------------------------------------------------------------

function Array:values_at(...)
  local elements = {}

  for _, at in ipairs({ ... }) do -- index or a range
    local noneOneMany = self:slice(at):derubik()

    if type(noneOneMany) ~= "table" then
      noneOneMany = { noneOneMany }
    end

    for _, element in ipairs(noneOneMany) do
      table.insert(elements, element)
    end
  end

  return Array.rubik(elements)
end

-- Array#dig
-- ---------------------------------------------------------------------

function Array:dig(...)
  local reached = self.__lua

  for _, index in ipairs({ ... }) do
    reached = Array.rubik.at(reached, index)
  end

  return Array.rubik(reached)
end

-- Array#shuffle
-- ---------------------------------------------------------------------

function Array:shuffle(prng)
  local indices = Array:new(#self.__lua, _, function(index)
    return index
  end)

  local shuffled = {}

  prng = prng or function(max)
    return math.random(max)
  end

  for max = indices:size():derubik(), 1, -1 do
    local index = indices:delete_at(prng(max)):derubik()

    table.insert(shuffled, self.__lua[index])
  end

  return Array.rubik(shuffled)
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

function Array:cycle(count, block)
  if count then
    for _ = 1, count, 1 do
      self:each(block)
    end
  else
    while true do
      self:each(block)
    end
  end

  return Array.rubik(nil)
end

-- Array#inspect
-- ---------------------------------------------------------------------

function Array:inspect()
  return Array.rubik(inspect(self.__lua))
end

-- Array#to_s alias

function Array:to_s()
  return self:inspect()
end

-- Array#__tostring metamethod

function Array:__tostring()
  return self:inspect():derubik()
end

-- Array#sum
-- ---------------------------------------------------------------------

function Array:sum(init, block)
  local transform = block or function(x)
    return x
  end

  local total = init or 0

  for _, value in ipairs(self.__lua) do
    total = total + transform(value) -- TODO: Replace `+ operator` with `+ method`
  end

  return Array.rubik(total)
end

-- ---------------------------------------------------------------------

return Array
