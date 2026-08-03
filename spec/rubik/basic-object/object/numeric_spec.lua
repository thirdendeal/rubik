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
      assert.equal(rubik.Numeric.fromLiteral(10):floor():derubik(), 10)
      assert.equal(rubik.Numeric.fromLiteral(10.25):floor():derubik(), 10)
      assert.equal(rubik.Numeric.fromLiteral(10.5):floor():derubik(), 10)
      assert.equal(rubik.Numeric.fromLiteral(10.75):floor():derubik(), 10)
    end)

    test("numeric:floor(ndigits) -> float or integer", function()
      local n = rubik.Numeric.fromLiteral(10.2859)

      assert.equal(n:floor(1):derubik(), 10.2)
      assert.equal(n:floor(2):derubik(), 10.28)
      assert.equal(n:floor(3):derubik(), 10.285)
      assert.equal(n:floor(4):derubik(), 10.2859)

      assert.equal(n:floor(100):derubik(), 10.2859)
    end)
  end)

  -- Numeric#ceil
  -- -------------------------------------------------------------------

  describe("Numeric#ceil", function()
    test("numeric:ceil() -> integer", function()
      assert.equal(rubik.Numeric.fromLiteral(10):ceil():derubik(), 10)

      assert.equal(rubik.Numeric.fromLiteral(10.25):ceil():derubik(), 11)
      assert.equal(rubik.Numeric.fromLiteral(10.5):ceil():derubik(), 11)
      assert.equal(rubik.Numeric.fromLiteral(10.75):ceil():derubik(), 11)
    end)

    test("numeric:ceil(ndigits) -> float or integer", function()
      local n = rubik.Numeric.fromLiteral(10.2859)

      assert.equal(n:ceil(1):derubik(), 10.3)
      assert.equal(n:ceil(2):derubik(), 10.29)
      assert.equal(n:ceil(3):derubik(), 10.286)
      assert.equal(n:ceil(4):derubik(), 10.2859)

      assert.equal(n:ceil(5):derubik(), 10.2859)
    end)
  end)

  -- Numeric#round
  -- -------------------------------------------------------------------

  describe("Numeric#round", function()
    test("numeric:round() -> integer", function()
      assert.equal(rubik.Numeric.fromLiteral(10):round():derubik(), 10)
      assert.equal(rubik.Numeric.fromLiteral(10.25):round():derubik(), 10)

      assert.equal(rubik.Numeric.fromLiteral(10.5):round():derubik(), 11)
      assert.equal(rubik.Numeric.fromLiteral(10.75):round():derubik(), 11)
    end)

    test("numeric:round(ndigits) -> float or integer", function()
      local n = rubik.Numeric.fromLiteral(10.2859)

      assert.equal(n:round(1):derubik(), 10.3)
      assert.equal(n:round(2):derubik(), 10.29)
      assert.equal(n:round(3):derubik(), 10.286)
      assert.equal(n:round(4):derubik(), 10.2859)

      assert.equal(n:round(5):derubik(), 10.2859)
    end)
  end)

  -- Numeric#modulo
  -- -------------------------------------------------------------------

  describe("Numeric#modulo", function()
    test("numeric:modulo(other) -> real numeric", function()
      assert.equal(rubik.modulo(27, 6), 3)
      assert.equal(rubik.modulo(-27, 6), 3)
      assert.equal(rubik.modulo(27, -6), -3)
      assert.equal(rubik.modulo(-27, -6), -3)

      assert.equal(rubik.modulo(6, 27), 6)
      assert.equal(rubik.modulo(-6, 27), 21)
      assert.equal(rubik.modulo(6, -27), -21)
      assert.equal(rubik.modulo(-6, -27), -6)
    end)
  end)

  -- Numeric#positive?
  -- -------------------------------------------------------------------

  describe("Numeric#positive?", function()
    test("numeric[\":positive?\"]() -> true or false", function()
      assert.equal(rubik["positive?"](1), true)

      assert.equal(rubik["positive?"](0), false)
      assert.equal(rubik["positive?"](-1), false)
    end)
  end)

  -- Numeric#negative?
  -- -------------------------------------------------------------------

  describe("Numeric#negative?", function()
    test("numeric[\":negative?\"]() -> true or false", function()
      assert.equal(rubik["negative?"](1), false)
      assert.equal(rubik["negative?"](0), false)

      assert.equal(rubik["negative?"](-1), true)
    end)
  end)

  -- Numeric#zero?
  -- -------------------------------------------------------------------

  describe("Numeric#zero?", function()
    test("numeric[\":zero?\"]() -> true or false", function()
      assert.equal(rubik["zero?"](1), false)
      assert.equal(rubik["zero?"](0), true)
      assert.equal(rubik["zero?"](-1), false)
    end)
  end)

  -- Numeric#nonzero?
  -- -------------------------------------------------------------------

  describe("Numeric#nonzero?", function()
    test("numeric[\":nonzero?\"]() -> true or false", function()
      assert.equal(rubik["nonzero?"](1), true)
      assert.equal(rubik["nonzero?"](0), false)
      assert.equal(rubik["nonzero?"](-1), true)
    end)
  end)
end)
