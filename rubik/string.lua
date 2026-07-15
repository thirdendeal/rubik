-- String
-- ---------------------------------------------------------------------

local class = require("middleclass")

local Object = require("rubik.object")

-- ---------------------------------------------------------------------

local String = class("String", Object)

-- ---------------------------------------------------------------------
-- Private
-- ---------------------------------------------------------------------

local _QUOTE_METHODS = { "empty?", "end_with?", "start_with?" }

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
      local substring = string.sub(self.__recipe, length - suffixLength + 1, length)

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
      local substring = string.sub(self.__recipe, 1, prefixLength)

      if substring == prefix then
        return self.class.rubik(true)
      end
    end
  end

  return self.class.rubik(false)
end

-- ---------------------------------------------------------------------

return String
