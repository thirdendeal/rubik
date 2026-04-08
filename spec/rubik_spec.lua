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

  test("rubik.newArray() -> empty array", function()
    local array = rubik.newArray()

    assert.equal(inspect(array), "{}")
  end)

  test("rubik.newArray(size) -> empty array", function()
    local array = rubik.newArray(1000)

    assert.equal(inspect(array), "{}")
  end)

  test("rubik.newArray(size, value) -> value array", function()
    local array = rubik.newArray(4, 1)

    assert.equal(inspect(array), "{ 1, 1, 1, 1 }")
  end)

  test("rubik.newArray(size, _, callback) -> callback(index) array", function()
    local array = rubik.newArray(4, nil, function(index)
      return math.pow(2, index)
    end)

    assert.equal(inspect(array), "{ 2, 4, 8, 16 }")
  end)

  -- Array#first
  -- -------------------------------------------------------------------

  test("rubik.first(array) -> first element", function()
    local element = rubik.first({ 1, 2, 3, 4 })

    assert.equal(element, 1)
  end)

  test("rubik.first(array, n) -> first n elements", function()
    local elements = rubik.first({ 1, 2, 3, 4 }, 2)

    assert.equal(inspect(elements), "{ 1, 2 }")
  end)

  -- Array#last
  -- -------------------------------------------------------------------

  test("rubik.last(array) -> last element", function()
    local element = rubik.last({ 1, 2, 3, 4 })

    assert.equal(element, 4)
  end)

  test("rubik.last(array, n) -> last n elements", function()
    local elements = rubik.last({ 1, 2, 3, 4 }, 2)

    assert.equal(inspect(elements), "{ 3, 4 }")
  end)
end)
