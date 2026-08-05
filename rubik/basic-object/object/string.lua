-- String
-- ---------------------------------------------------------------------

local class = require("middleclass")

local Object = require("rubik.basic-object.object")

-- ---------------------------------------------------------------------

local String = class("String", Object)

-- ---------------------------------------------------------------------
-- Private
-- ---------------------------------------------------------------------

local _QUOTE_METHODS = {
  "empty?",
  "end_with?",
  "start_with?",
  "capitalize!",
  "upcase!",
  "downcase!",
  "swapcase!",
  "reverse!"
}

-- ---------------------------------------------------------------------
-- Class
-- ---------------------------------------------------------------------

-- String::new (Rubik + Ruby)
-- ---------------------------------------------------------------------

function String:initialize(s)
  self.__lua = s

  String.rubik.patch_quote_methods(self, _QUOTE_METHODS)
end

-- String::fromLiteral

function String.static.fromLiteral(s)
  return String:new(s)
end

-- ---------------------------------------------------------------------
-- Instance
-- ---------------------------------------------------------------------

-- String#empty?
-- ---------------------------------------------------------------------

String["empty?"] = function(self)
  return String.rubik(#self.__lua == 0)
end

-- String#end_with?
-- ---------------------------------------------------------------------

String["end_with?"] = function(self, ...)
  local length = #self.__lua

  for _, suffix in ipairs({ ... }) do
    local suffixLength = #suffix

    if suffixLength <= length then
      local substring = self.__lua:sub(length - suffixLength + 1, length)

      if substring == suffix then
        return String.rubik(true)
      end
    end
  end

  return String.rubik(false)
end

-- String#start_with?
-- ---------------------------------------------------------------------

String["start_with?"] = function(self, ...)
  local length = #self.__lua

  for _, prefix in ipairs({ ... }) do
    local prefixLength = #prefix

    if prefixLength <= length then
      local substring = self.__lua:sub(1, prefixLength)

      if substring == prefix then
        return String.rubik(true)
      end
    end
  end

  return String.rubik(false)
end

-- String#capitalize
-- ---------------------------------------------------------------------
--
-- Missing: Case Mapping

function String:capitalize()
  local firstCharacter = self.__lua:sub(1, 1)
  local remainder = self.__lua:sub(2, #self.__lua)

  return String.rubik(firstCharacter:upper() .. remainder:lower())
end

-- String#capitalize!

String["capitalize!"] = function(self)
  local initial = self.__lua
  self.__lua = self:capitalize():derubik()

  if self.__lua ~= initial then
    return self
  end

  return String.rubik(nil)
end

-- String#downcase
-- ---------------------------------------------------------------------
--
-- Missing: Case Mapping

function String:downcase()
  return String.rubik(self.__lua:lower())
end

-- String#downcase!

String["downcase!"] = function(self)
  local initial = self.__lua
  self.__lua = self:downcase():derubik()

  if self.__lua ~= initial then
    return self
  end

  return String.rubik(nil)
end

-- String#upcase
-- ---------------------------------------------------------------------
--
-- Missing: Case Mapping

function String:upcase()
  return String.rubik(self.__lua:upper())
end

-- String#upcase!

String["upcase!"] = function(self)
  local initial = self.__lua
  self.__lua = self:upcase():derubik()

  if self.__lua ~= initial then
    return self
  end

  return String.rubik(nil)
end

-- String#swapcase
-- ---------------------------------------------------------------------
--
-- Missing: Case Mapping

function String:swapcase()
  local cumulation = ""

  for i = 1, #self.__lua do
    local character = self.__lua:sub(i, i)
    local lowerCase = character:lower()

    if character == lowerCase then
      cumulation = cumulation .. character:upper()
    else
      cumulation = cumulation .. lowerCase
    end
  end

  return String.rubik(cumulation)
end

-- String#swapcase!

String["swapcase!"] = function(self)
  local initial = self.__lua
  self.__lua = self:swapcase():derubik()

  if self.__lua ~= initial then
    return self
  end

  return String.rubik(nil)
end

-- String#reverse
-- ---------------------------------------------------------------------

function String:reverse()
  local cumulation = ""

  for i = #self.__lua, 1, -1 do
    local character = self.__lua:sub(i, i)

    cumulation = cumulation .. character
  end

  return String.rubik(cumulation)
end

-- String#reverse!

String["reverse!"] = function(self)
  self.__lua = self:reverse():derubik()

  return self
end

-- ---------------------------------------------------------------------

return String
