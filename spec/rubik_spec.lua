-- Rubik Test
-- ---------------------------------------------------------------------

local inspect = require("inspect")

local rubik = require("../rubik")

-- (Proof of concept)
-- ---------------------------------------------------------------------

describe("rubik.each", function()
  it("returns the given table", function()
    local t = { 1, 2, 3 }

    assert.are.equal(rubik.each(t), t)
  end)
end)

-- ---------------------------------------------------------------------
-- Array
-- ---------------------------------------------------------------------

describe("Array", function()
  -- Array#new (newArray)
  -- -------------------------------------------------------------------

  it("rubik.newArray() -> {}", function()
    local emptyArray = rubik.newArray()

    assert.equal(inspect(emptyArray), "{}")
  end)

  it("rubik.newArray(1, \"value\") -> { \"value\" }", function()
    local valueFilledArray = rubik.newArray(1, "value")

    assert.equal(inspect(valueFilledArray), "{ \"value\" }")
  end)

  it("rubik.newArray(2, \"ignored\", function(index) return index * 2 end) -> { 2, 4 }", function()
    local callbackFilledArray = rubik.newArray(2, "ignored", function(index)
      return index * 2
    end)

    assert.equal(inspect(callbackFilledArray), "{ 2, 4 }")
  end)

  it("rubik.newArray(3) -> {}", function()
    local cannotNilFill = rubik.newArray(3) -- rubik.newArray(3, nil)

    assert.equal(inspect(cannotNilFill), "{}")
  end)

  -- Array#first
  -- -------------------------------------------------------------------

  it("rubik.first({ 1, 2, 3, 4 }) -> 1", function()
    local firstElement = rubik.first({ 1, 2, 3, 4 })

    assert.equal(firstElement, 1)
  end)

  it("rubik.first({ 1, 2, 3 }, 2) -> { 1, 2 }", function()
    local firstTwoElements = rubik.first({ 1, 2, 3, 4 }, 2)

    assert.equal(inspect(firstTwoElements), "{ 1, 2 }")
  end)

  -- Array#last
  -- -------------------------------------------------------------------

  it("rubik.last({ 1, 2, 3 }) -> 3", function()
    local lastElement = rubik.last({ 1, 2, 3, 4 })

    assert.equal(lastElement, 4)
  end)

  it("rubik.last({ 1, 2, 3, 4 }, 2) -> { 1, 2 }", function()
    local lastTwoElements = rubik.last({ 1, 2, 3, 4 }, 2)

    assert.equal(inspect(lastTwoElements), "{ 3, 4 }")
  end)
end)
