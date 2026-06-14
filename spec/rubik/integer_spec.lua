-- Integer Spec
-- ---------------------------------------------------------------------

local inspect = require("inspect")

local rubik = require("rubik")

-- Integer
-- ---------------------------------------------------------------------

describe("Integer", function()
  -- -------------------------------------------------------------------
  -- Class
  -- -------------------------------------------------------------------

  -- Integer::wrap
  -- -------------------------------------------------------------------

  describe("Integer::wrap", function()
    test("Integer.wrap(value) -> new integer", function()
      local integer = rubik.Integer.wrap(1)

      assert.equal(integer:unwrap(), 1)
    end)
  end)

  -- -------------------------------------------------------------------
  -- Instance
  -- -------------------------------------------------------------------

  -- Integer#even?
  -- -------------------------------------------------------------------

  describe("Integer#first", function()
    test("integer[\":even?\"]() -> true or false", function()
      assert.equal(rubik[":even?"](1), false)
      assert.equal(rubik[":even?"](2), true)
    end)
  end)
end)
