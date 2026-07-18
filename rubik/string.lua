-- String
-- ---------------------------------------------------------------------
--
-- Missing: Case Mapping

local class = require("middleclass")

local Object = require("rubik.object")

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
  "swapcase!"
}

-- ---------------------------------------------------------------------
-- Class
-- ---------------------------------------------------------------------

-- String::wrap
-- ---------------------------------------------------------------------

function String.static.wrap(value)
  local object = String:new()

  object.__recipe = value
  object.class.rubik.patch_quote_methods(object, _QUOTE_METHODS)

  return object
end

-- ---------------------------------------------------------------------
-- Instance
-- ---------------------------------------------------------------------

-- String#empty?
-- ---------------------------------------------------------------------

String["empty?"] = function(self)
  return self.class.rubik(#self.__recipe == 0)
end

-- String#end_with?
-- ---------------------------------------------------------------------

String["end_with?"] = function(self, ...)
  local length = #self.__recipe

  for _, suffix in ipairs({ ... }) do
    local suffixLength = #suffix

    if suffixLength <= length then
      local substring = self.__recipe:sub(length - suffixLength + 1, length)

      if substring == suffix then
        return self.class.rubik(true)
      end
    end
  end

  return self.class.rubik(false)
end

-- String#start_with?
-- ---------------------------------------------------------------------

String["start_with?"] = function(self, ...)
  local length = #self.__recipe

  for _, prefix in ipairs({ ... }) do
    local prefixLength = #prefix

    if prefixLength <= length then
      local substring = self.__recipe:sub(1, prefixLength)

      if substring == prefix then
        return self.class.rubik(true)
      end
    end
  end

  return self.class.rubik(false)
end

-- String#capitalize
-- ---------------------------------------------------------------------

function String:capitalize()
  local firstCharacter = self.__recipe:sub(1, 1)
  local remainder = self.__recipe:sub(2, #self.__recipe)

  return self.class.rubik(firstCharacter:upper() .. remainder:lower())
end

-- String#capitalize!

String["capitalize!"] = function(self)
  local initial = self.__recipe
  self.__recipe = self:capitalize():unwrap()

  if self.__recipe ~= initial then
    return self
  end

  return self.class.rubik(nil)
end

-- String#downcase
-- ---------------------------------------------------------------------

function String:downcase()
  return self.class.rubik(self.__recipe:lower())
end

-- String#downcase!

String["downcase!"] = function(self)
  local initial = self.__recipe
  self.__recipe = self:downcase():unwrap()

  if self.__recipe ~= initial then
    return self
  end

  return self.class.rubik(nil)
end

-- String#upcase
-- ---------------------------------------------------------------------

function String:upcase()
  return self.class.rubik(self.__recipe:upper())
end

-- String#upcase!

String["upcase!"] = function(self)
  local initial = self.__recipe
  self.__recipe = self:upcase():unwrap()

  if self.__recipe ~= initial then
    return self
  end

  return self.class.rubik(nil)
end

-- String#swapcase
-- ---------------------------------------------------------------------

function String:swapcase()
  local cumulation = ""

  for i = 1, #self.__recipe do
    local character = self.__recipe:sub(i, i)
    local lowerCase = character:lower()

    if character == lowerCase then
      cumulation = cumulation .. character:upper()
    else
      cumulation = cumulation .. lowerCase
    end
  end

  return self.class.rubik(cumulation)
end

-- String#swapcase!

String["swapcase!"] = function(self)
  local initial = self.__recipe
  self.__recipe = self:swapcase():unwrap()

  if self.__recipe ~= initial then
    return self
  end

  return self.class.rubik(nil)
end

-- ---------------------------------------------------------------------

return String
