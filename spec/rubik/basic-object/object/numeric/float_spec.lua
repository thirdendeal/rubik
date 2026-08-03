-- Float Spec
-- ---------------------------------------------------------------------

local inspect = require("inspect")

local rubik = require("rubik")

-- Float
-- ---------------------------------------------------------------------

describe("Float", function()
  -- -------------------------------------------------------------------
  -- Instance
  -- -------------------------------------------------------------------

  -- Float#floor
  -- -------------------------------------------------------------------

  describe("Float#floor", function()
    test("float:floor() -> integer", function()
      assert.equal(rubik.Float.fromLiteral(10):floor():derubik(), 10)
      assert.equal(rubik.Float.fromLiteral(10.25):floor():derubik(), 10)
      assert.equal(rubik.Float.fromLiteral(10.5):floor():derubik(), 10)
      assert.equal(rubik.Float.fromLiteral(10.75):floor():derubik(), 10)
    end)

    test("float:floor(ndigits) -> float or integer", function()
      local f = rubik.Float.fromLiteral(10.2859)

      assert.equal(f:floor(1):derubik(), 10.2)
      assert.equal(f:floor(2):derubik(), 10.28)
      assert.equal(f:floor(3):derubik(), 10.285)
      assert.equal(f:floor(4):derubik(), 10.2859)

      assert.equal(f:floor(100):derubik(), 10.2859)
    end)
  end)

  -- Float#ceil
  -- -------------------------------------------------------------------

  describe("Float#ceil", function()
    test("float:ceil() -> integer", function()
      assert.equal(rubik.Float.fromLiteral(10):ceil():derubik(), 10)

      assert.equal(rubik.Float.fromLiteral(10.25):ceil():derubik(), 11)
      assert.equal(rubik.Float.fromLiteral(10.5):ceil():derubik(), 11)
      assert.equal(rubik.Float.fromLiteral(10.75):ceil():derubik(), 11)
    end)

    test("float:ceil(ndigits) -> float or integer", function()
      local f = rubik.Float.fromLiteral(10.2859)

      assert.equal(f:ceil(1):derubik(), 10.3)
      assert.equal(f:ceil(2):derubik(), 10.29)
      assert.equal(f:ceil(3):derubik(), 10.286)
      assert.equal(f:ceil(4):derubik(), 10.2859)

      assert.equal(f:ceil(5):derubik(), 10.2859)
    end)
  end)

  -- Float#round
  -- -------------------------------------------------------------------

  describe("Float#round", function()
    test("float:round() -> integer", function()
      assert.equal(rubik.Float.fromLiteral(10):round():derubik(), 10)
      assert.equal(rubik.Float.fromLiteral(10.25):round():derubik(), 10)

      assert.equal(rubik.Float.fromLiteral(10.5):round():derubik(), 11)
      assert.equal(rubik.Float.fromLiteral(10.75):round():derubik(), 11)
    end)

    test("float:round(ndigits) -> float or integer", function()
      local f = rubik.Float.fromLiteral(10.2859)

      assert.equal(f:round(1):derubik(), 10.3)
      assert.equal(f:round(2):derubik(), 10.29)
      assert.equal(f:round(3):derubik(), 10.286)
      assert.equal(f:round(4):derubik(), 10.2859)

      assert.equal(f:round(5):derubik(), 10.2859)
    end)
  end)
end)
