-- FalseClass Spec
-- -----------------------------------------------------------------------------

local inspect = require("inspect")

local rubik = require("rubik")

-- FalseClass
-- -----------------------------------------------------------------------------

describe("FalseClass", function()
  -- ---------------------------------------------------------------------------
  -- Class
  -- ---------------------------------------------------------------------------

  -- FalseClass::new
  -- ---------------------------------------------------------------------------

  describe("FalseClass::new", function()
    test("FalseClass:new() -> new false object", function()
      local f = rubik.FalseClass:new()

      assert.equal(f:derubik(), false)
    end)
  end)

  -- FalseClass::fromLiteral
  -- ---------------------------------------------------------------------------

  describe("FalseClass::fromLiteral", function()
    test("FalseClass:fromLiteral() -> new false object", function()
      local f = rubik.FalseClass:fromLiteral()

      assert.equal(f:derubik(), false)
    end)
  end)
end)
