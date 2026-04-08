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

  -- Array#at
  -- -------------------------------------------------------------------

  test("rubik.at(array, index) -> element", function()
    local array = { 2, 4, 8, 16 }

    assert.equal(rubik.at(array, 1), 2)
    assert.equal(rubik.at(array, 100), nil)
    assert.equal(rubik.at(array, -1), 16)
    assert.equal(rubik.at(array, -100), nil)
  end)

  -- Array#fetch
  -- -------------------------------------------------------------------

  test("rubik.fetch(array, index) -> element", function()
    local array = { 1, 2, 3, 4 }

    assert.equal(rubik.fetch(array, 1), 1)
    assert.equal(rubik.fetch(array, 0), nil)
    assert.equal(rubik.fetch(array, -1), 4)
  end)

  test("rubik.fetch(array, index, fallback) -> element", function()
    local array = { 1, 2, 3, 4 }

    assert.equal(rubik.fetch(array, 1, "fallback"), 1)
    assert.equal(rubik.fetch(array, 0, "fallback"), "fallback")
    assert.equal(rubik.fetch(array, -1, "fallback"), 4)
  end)

  test("rubik.fetch(array, index, _, callback) -> element", function()
    local array = { 1, 2, 3, 4 }

    local missing = function(index)
      return "No element at " .. index
    end

    assert.equal(rubik.fetch(array, 1, nil, missing), 1)
    assert.equal(rubik.fetch(array, 0, nil, missing), "No element at 0")
  end)

  -- Array#slice
  -- -------------------------------------------------------------------

  test("rubik.slice(array, range) -> subset array", function()
    local array = { 2, 4, 8, 16, 32, 64, 128, 256 }

    assert.equal(inspect(rubik.slice(array, { 2, 2 })), "{ 4 }")
    assert.equal(inspect(rubik.slice(array, { 2, 4 })), "{ 4, 8, 16 }")
    assert.equal(inspect(rubik.slice(array, { 2, 100 })), "{ 4, 8, 16, 32, 64, 128, 256 }")
  end)

  test("rubik.slice(array, index) -> element", function()
    local array = { 2, 4, 8, 16, 32, 64, 128, 256 }

    assert.equal(rubik.slice(array, 2), 4)
    assert.equal(rubik.slice(array, 100), nil)
    assert.equal(rubik.slice(array, -1), 256)
    assert.equal(rubik.slice(array, -100), nil)
  end)

  test("rubik.slice(array, start, length) -> subset array", function()
    local array = { 2, 4, 8, 16, 32, 64, 128, 256 }

    assert.equal(inspect(rubik.slice(array, 2, 1)), "{ 4 }")
    assert.equal(inspect(rubik.slice(array, 2, 4)), "{ 4, 8, 16, 32 }")
    assert.equal(inspect(rubik.slice(array, 2, 100)), "{ 4, 8, 16, 32, 64, 128, 256 }")
  end)
end)
