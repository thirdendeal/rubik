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
      assert.equal(rubik.Float.wrap(10):floor():unwrap(), 10)
      assert.equal(rubik.Float.wrap(10.25):floor():unwrap(), 10)
      assert.equal(rubik.Float.wrap(10.5):floor():unwrap(), 10)
      assert.equal(rubik.Float.wrap(10.75):floor():unwrap(), 10)
    end)

    test("float:floor(ndigits) -> float or integer", function()
      local f = rubik.Float.wrap(10.2859)

      assert.equal(f:floor(1):unwrap(), 10.2)
      assert.equal(f:floor(2):unwrap(), 10.28)
      assert.equal(f:floor(3):unwrap(), 10.285)
      assert.equal(f:floor(4):unwrap(), 10.2859)

      assert.equal(f:floor(100):unwrap(), 10.2859)
    end)
  end)

  -- Float#ceil
  -- -------------------------------------------------------------------

  describe("Float#ceil", function()
    test("float:ceil() -> integer", function()
      assert.equal(rubik.Float.wrap(10):ceil():unwrap(), 10)

      assert.equal(rubik.Float.wrap(10.25):ceil():unwrap(), 11)
      assert.equal(rubik.Float.wrap(10.5):ceil():unwrap(), 11)
      assert.equal(rubik.Float.wrap(10.75):ceil():unwrap(), 11)
    end)

    test("float:ceil(ndigits) -> float or integer", function()
      local f = rubik.Float.wrap(10.2859)

      assert.equal(f:ceil(1):unwrap(), 10.3)
      assert.equal(f:ceil(2):unwrap(), 10.29)
      assert.equal(f:ceil(3):unwrap(), 10.286)
      assert.equal(f:ceil(4):unwrap(), 10.2859)

      assert.equal(f:ceil(5):unwrap(), 10.2859)
    end)
  end)

  -- Float#round
  -- -------------------------------------------------------------------

  describe("Float#round", function()
    test("float:round() -> integer", function()
      assert.equal(rubik.Float.wrap(10):round():unwrap(), 10)
      assert.equal(rubik.Float.wrap(10.25):round():unwrap(), 10)

      assert.equal(rubik.Float.wrap(10.5):round():unwrap(), 11)
      assert.equal(rubik.Float.wrap(10.75):round():unwrap(), 11)
    end)

    test("float:round(ndigits) -> float or integer", function()
      local f = rubik.Float.wrap(10.2859)

      assert.equal(f:round(1):unwrap(), 10.3)
      assert.equal(f:round(2):unwrap(), 10.29)
      assert.equal(f:round(3):unwrap(), 10.286)
      assert.equal(f:round(4):unwrap(), 10.2859)

      assert.equal(f:round(5):unwrap(), 10.2859)
    end)
  end)
end)
