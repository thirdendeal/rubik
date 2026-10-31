-- TrueClass Spec
-- -----------------------------------------------------------------------------

local inspect = require("inspect")

local rubik = require("rubik")

-- TrueClass
-- -----------------------------------------------------------------------------

describe("TrueClass", function()
  -- ---------------------------------------------------------------------------
  -- Public Class Methods
  -- ---------------------------------------------------------------------------

  -- TrueClass::new
  -- ---------------------------------------------------------------------------

  describe("TrueClass::new", function()
    test("TrueClass:new() -> new true object", function()
      local t = rubik.TrueClass:new()

      assert.equal(t:derubik(), true)
    end)
  end)
end)
