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

-- Array
-- ---------------------------------------------------------------------

describe("Array", function()
  -- Array#newArray
  -- -------------------------------------------------------------------

  it("rubik.newArray() -> {}", function()
    local array = rubik.newArray()

    assert.equal(inspect(array), "{}")
  end)

  it("rubik.newArray(1) -> {}", function()
    local array = rubik.newArray(1)

    assert.equal(inspect(array), "{}")
  end)

  it('rubik.newArray(2, "a") -> { "a", "a" }', function()
    local array = rubik.newArray(2, "a")

    assert.equal(inspect(array), '{ "a", "a" }')
  end)

  it('rubik.newArray(3, "ignored", function(index) return index end) -> { 1, 2, 3 }', function()
    local array = rubik.newArray(3, "ignored", function(index) return index end)

    assert.equal(inspect(array), "{ 1, 2, 3 }")
  end)

  -- Array#first
  -- -------------------------------------------------------------------

  it('rubik.first({ 1, 2, 3, 4 }) -> 1', function()
    local first = rubik.first({ 1, 2, 3, 4 })

    assert.equal(first, 1)
  end)

  it('rubik.first({ 1, 2, 3 }, 2) -> { 1, 2 }', function()
    local first = rubik.first({ 1, 2, 3, 4 }, 2)

    assert.equal(inspect(first), "{ 1, 2 }")
  end)

  -- Array#last
  -- -------------------------------------------------------------------

  it('rubik.last({ 1, 2, 3 }) -> 3', function()
    local last = rubik.last({ 1, 2, 3, 4 })

    assert.equal(last, 4)
  end)

  it('rubik.last({ 1, 2, 3, 4 }, 2) -> { 1, 2 }', function()
    local last = rubik.last({ 1, 2, 3, 4 }, 2)

    assert.equal(inspect(last), "{ 3, 4 }")
  end)
end)
