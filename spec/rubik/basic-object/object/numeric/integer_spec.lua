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

  -- Integer::fromLiteral
  -- -------------------------------------------------------------------

  describe("Integer::fromLiteral", function()
    test("Integer.fromLiteral(value) -> new integer", function()
      local integer = rubik.Integer.fromLiteral(1)

      assert.equal(integer:derubik(), 1)
    end)
  end)

  -- -------------------------------------------------------------------
  -- Instance
  -- -------------------------------------------------------------------

  -- Integer#even?
  -- -------------------------------------------------------------------

  describe("Integer#even?", function()
    test("integer[\":even?\"]() -> true or false", function()
      assert.equal(rubik["even?"](0), true)

      assert.equal(rubik["even?"](1), false)
      assert.equal(rubik["even?"](2), true)
    end)
  end)

  -- Integer#odd?
  -- -------------------------------------------------------------------

  describe("Integer#odd?", function()
    test("integer[\":odd?\"]() -> true or false", function()
      assert.equal(rubik["odd?"](0), false)

      assert.equal(rubik["odd?"](1), true)
      assert.equal(rubik["odd?"](2), false)
    end)
  end)

  -- Integer#zero?
  -- -------------------------------------------------------------------

  describe("Integer#zero?", function()
    test("integer[\":zero?\"]() -> true or false", function()
      assert.equal(rubik["zero?"](1), false)
      assert.equal(rubik["zero?"](0), true)
    end)
  end)

  -- Integer#abs (Integer#magnitude alias)
  -- -------------------------------------------------------------------

  describe("Integer#abs (Integer#magnitude alias)", function()
    test("integer:abs() -> integer", function()
      assert.equal(rubik.abs(100), 100)
      assert.equal(rubik.abs(-100), 100)
    end)
  end)

  -- Integer#succ (Integer#next alias)
  -- -------------------------------------------------------------------

  describe("Integer#succ (Integer#next alias)", function()
    test("integer:succ() -> integer", function()
      assert.equal(rubik.succ(1), 2)
      assert.equal(rubik.succ(-1), 0)
    end)
  end)
end)
