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

  describe("Integer#even?", function()
    test("integer[\":even?\"]() -> true or false", function()
      assert.equal(rubik[":even?"](0), true)

      assert.equal(rubik[":even?"](1), false)
      assert.equal(rubik[":even?"](2), true)
    end)
  end)

  -- Integer#odd?
  -- -------------------------------------------------------------------

  describe("Integer#odd?", function()
    test("integer[\":odd?\"]() -> true or false", function()
      assert.equal(rubik[":odd?"](0), false)

      assert.equal(rubik[":odd?"](1), true)
      assert.equal(rubik[":odd?"](2), false)
    end)
  end)

  -- Integer#zero?
  -- -------------------------------------------------------------------

  describe("Integer#zero?", function()
    test("integer[\":zero?\"]() -> true or false", function()
      assert.equal(rubik[":zero?"](1), false)
      assert.equal(rubik[":zero?"](0), true)
    end)
  end)
end)
