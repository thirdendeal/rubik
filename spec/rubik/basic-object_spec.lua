-- BasicObject Spec
-- ---------------------------------------------------------------------

local inspect = require("inspect")

local rubik = require("rubik")

-- BasicObject
-- ---------------------------------------------------------------------

describe("BasicObject", function()
  -- -------------------------------------------------------------------
  -- Instance
  -- -------------------------------------------------------------------

  -- BasicObject#derubik
  -- -------------------------------------------------------------------

  describe("BasicObject#derubik", function()
    test("basicObject:derubik() -> lua value", function()
      assert.equal(rubik(1):derubik(), 1) -- Integer -> super BasicObject#derubik

      local e = rubik.Enumerator.produce(1, rubik.succ)

      local success, _ = pcall(function() e:derubik() end) -- throws NoLuaEquivalent error
      assert.equal(success, false)
    end)
  end)
end)
