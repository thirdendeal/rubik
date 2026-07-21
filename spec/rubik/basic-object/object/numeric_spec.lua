-- Numeric Spec
-- ---------------------------------------------------------------------

local inspect = require("inspect")

local rubik = require("rubik")

-- Numeric
-- ---------------------------------------------------------------------

describe("Numeric", function()
  -- -------------------------------------------------------------------
  -- Instance
  -- -------------------------------------------------------------------

  -- Numeric#floor
  -- -------------------------------------------------------------------

  describe("Numeric#floor", function()
    test("numeric:floor() -> integer", function()
      assert.equal(rubik.Numeric.wrap(10):floor():unwrap(), 10)
      assert.equal(rubik.Numeric.wrap(10.25):floor():unwrap(), 10)
      assert.equal(rubik.Numeric.wrap(10.5):floor():unwrap(), 10)
      assert.equal(rubik.Numeric.wrap(10.75):floor():unwrap(), 10)
    end)

    test("numeric:floor(ndigits) -> float or integer", function()
      local n = rubik.Numeric.wrap(10.2859)

      assert.equal(n:floor(1):unwrap(), 10.2)
      assert.equal(n:floor(2):unwrap(), 10.28)
      assert.equal(n:floor(3):unwrap(), 10.285)
      assert.equal(n:floor(4):unwrap(), 10.2859)

      assert.equal(n:floor(100):unwrap(), 10.2859)
    end)
  end)

  -- Numeric#ceil
  -- -------------------------------------------------------------------

  describe("Numeric#ceil", function()
    test("numeric:ceil() -> integer", function()
      assert.equal(rubik.Numeric.wrap(10):ceil():unwrap(), 10)

      assert.equal(rubik.Numeric.wrap(10.25):ceil():unwrap(), 11)
      assert.equal(rubik.Numeric.wrap(10.5):ceil():unwrap(), 11)
      assert.equal(rubik.Numeric.wrap(10.75):ceil():unwrap(), 11)
    end)

    test("numeric:ceil(ndigits) -> float or integer", function()
      local n = rubik.Numeric.wrap(10.2859)

      assert.equal(n:ceil(1):unwrap(), 10.3)
      assert.equal(n:ceil(2):unwrap(), 10.29)
      assert.equal(n:ceil(3):unwrap(), 10.286)
      assert.equal(n:ceil(4):unwrap(), 10.2859)

      assert.equal(n:ceil(5):unwrap(), 10.2859)
    end)
  end)

  -- Numeric#round
  -- -------------------------------------------------------------------

  describe("Numeric#round", function()
    test("numeric:round() -> integer", function()
      assert.equal(rubik.Numeric.wrap(10):round():unwrap(), 10)
      assert.equal(rubik.Numeric.wrap(10.25):round():unwrap(), 10)

      assert.equal(rubik.Numeric.wrap(10.5):round():unwrap(), 11)
      assert.equal(rubik.Numeric.wrap(10.75):round():unwrap(), 11)
    end)

    test("numeric:round(ndigits) -> float or integer", function()
      local n = rubik.Numeric.wrap(10.2859)

      assert.equal(n:round(1):unwrap(), 10.3)
      assert.equal(n:round(2):unwrap(), 10.29)
      assert.equal(n:round(3):unwrap(), 10.286)
      assert.equal(n:round(4):unwrap(), 10.2859)

      assert.equal(n:round(5):unwrap(), 10.2859)
    end)
  end)
end)
