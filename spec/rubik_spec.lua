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

  test("rubik.newArray() -> new empty array", function()
    local array = rubik.newArray()

    assert.equal(inspect(array), "{}")
  end)

  test("rubik.newArray(size) -> new empty array", function()
    local array = rubik.newArray(1000)

    assert.equal(inspect(array), "{}")
  end)

  test("rubik.newArray(size, value) -> new populated array", function()
    local array = rubik.newArray(4, 1)

    assert.equal(inspect(array), "{ 1, 1, 1, 1 }")
  end)

  test("rubik.newArray(size, _, callback(index)) -> new populated array", function()
    local array = rubik.newArray(4, _, function(index)
      return math.pow(2, index)
    end)

    assert.equal(inspect(array), "{ 2, 4, 8, 16 }")
  end)

  -- Array#first (Array#take)
  -- -------------------------------------------------------------------

  test("rubik.first(array) -> first element", function()
    local array = { 2, 4, 8, 16 }
    assert.equal(rubik.first(array), 2)

    local empty = {}
    assert.equal(rubik.first(empty), nil)
  end)

  test("rubik.first(array, n) -> first n elements (new array)", function()
    local array = { 2, 4, 8, 16 }

    assert.equal(inspect(rubik.first(array, 0)), "{}")
    assert.equal(inspect(rubik.first(array, 1)), "{ 2 }")
    assert.equal(inspect(rubik.first(array, 2)), "{ 2, 4 }")
    assert.equal(inspect(rubik.first(array, 100)), "{ 2, 4, 8, 16 }")

    local empty = {}
    assert.equal(inspect(rubik.first(empty, 0)), "{}")
    assert.equal(inspect(rubik.first(empty, 1)), "{}")
  end)

  -- Array#last
  -- -------------------------------------------------------------------

  test("rubik.last(array) -> last element", function()
    local array = { 2, 4, 8, 16 }
    assert.equal(rubik.last(array), 16)

    local empty = {}
    assert.equal(rubik.last(empty), nil)
  end)

  test("rubik.last(array, n) -> last n elements (new array)", function()
    local array = { 2, 4, 8, 16 }

    assert.equal(inspect(rubik.last(array, 0)), "{}")
    assert.equal(inspect(rubik.last(array, 1)), "{ 16 }")
    assert.equal(inspect(rubik.last(array, 2)), "{ 8, 16 }")
    assert.equal(inspect(rubik.last(array, 100)), "{ 2, 4, 8, 16 }")

    local empty = {}
    assert.equal(inspect(rubik.last(empty, 0)), "{}")
    assert.equal(inspect(rubik.last(empty, 1)), "{}")
  end)

  -- Array#drop
  -- -------------------------------------------------------------------

  test("rubik.drop(array, n) -> new array without the n last elements", function()
    local array = { 2, 4, 8, 16 }

    assert.equal(inspect(rubik.drop(array, 0)), "{ 2, 4, 8, 16 }")
    assert.equal(inspect(rubik.drop(array, 1)), "{ 2, 4, 8 }")
    assert.equal(inspect(rubik.drop(array, 2)), "{ 2, 4 }")
    assert.equal(inspect(rubik.drop(array, 100)), "{}")

    local empty = {}
    assert.equal(inspect(rubik.drop(empty, 0)), "{}")
    assert.equal(inspect(rubik.drop(empty, 1)), "{}")
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

  test("rubik.fetch(array, index, _, callback(index)) -> element", function()
    local array = { 1, 2, 3, 4 }

    local missing = function(index)
      return "No element at " .. index
    end

    assert.equal(rubik.fetch(array, 1, _, missing), 1)
    assert.equal(rubik.fetch(array, 0, _, missing), "No element at 0")
  end)

  -- Array#slice
  -- -------------------------------------------------------------------

  test("rubik.slice(array, range) -> new subset array", function()
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

  test("rubik.slice(array, start, length) -> new subset array", function()
    local array = { 2, 4, 8, 16, 32, 64, 128, 256 }

    assert.equal(inspect(rubik.slice(array, 2, 1)), "{ 4 }")
    assert.equal(inspect(rubik.slice(array, 2, 4)), "{ 4, 8, 16, 32 }")
    assert.equal(inspect(rubik.slice(array, 2, 100)), "{ 4, 8, 16, 32, 64, 128, 256 }")
  end)

  -- Array#size (Array#length)
  -- -------------------------------------------------------------------

  test("rubik.size(array) -> integer", function()
    local array = { 2, 4, 8, 16 }
    assert.equal(rubik.size(array), 4)

    local empty = {}
    assert.equal(rubik.size(empty), 0)
  end)

  -- Array#count
  -- -------------------------------------------------------------------

  test("rubik.count(array) -> integer", function()
    local array = { 2, 4, 8, 16 }
    assert.equal(rubik.count(array), 4)

    local empty = {}
    assert.equal(rubik.count(empty), 0)
  end)

  test("rubik.count(array, element) -> integer", function()
    local array = { 1, 1, 2, 3 }

    assert.equal(rubik.count(array, 1), 2)
    assert.equal(rubik.count(array, 2), 1)
    assert.equal(rubik.count(array, "3"), 0)
  end)

  test("rubik.count(array, _, callback) -> integer", function()
    local array = { 1, 1, 2, 3 }

    local isEven = function(number)
      return (number % 2) == 0
    end

    assert.equal(rubik.count(array, _, isEven), 1)
  end)

  -- Array#isEmpty
  -- -------------------------------------------------------------------

  test("rubik.isEmpty(array) -> boolean", function()
    local array = { 2, 4, 8, 16 }
    assert.equal(rubik.isEmpty(array), false)

    local empty = {}
    assert.equal(rubik.isEmpty(empty), true)
  end)

  -- Array#include? (doesInclude)
  -- -------------------------------------------------------------------

  test("rubik.doesInclude(array, value) -> boolean", function()
    local array = { 2, 4, 8, 16 }

    assert.equal(rubik.doesInclude(array, 8), true)
    assert.equal(rubik.doesInclude(array, "8"), false)
  end)

  -- Array#push
  -- -------------------------------------------------------------------

  test("rubik.push(array, ...) -> input array", function()
    local array = {}

    assert.equal(inspect(rubik.push(array, 2)), "{ 2 }")
    assert.equal(inspect(rubik.push(array, 4, 8, 16)), "{ 2, 4, 8, 16 }")
  end)

  -- Array#unshift
  -- -------------------------------------------------------------------

  test("rubik.unshift(array, ...) -> input array", function()
    local array = {}

    assert.equal(inspect(rubik.unshift(array, 16)), "{ 16 }")
    assert.equal(inspect(rubik.unshift(array, 2, 4, 8)), "{ 2, 4, 8, 16 }")
  end)

  -- Array#insert
  -- -------------------------------------------------------------------

  test("rubik.insert(array, index, ...) -> input array", function()
    local array = {}

    assert.equal(inspect(rubik.insert(array, 1, 4)), "{ 4 }")
    assert.equal(inspect(rubik.insert(array, 1, 2)), "{ 2, 4 }")
    assert.equal(inspect(rubik.insert(array, 3, 8, 16)), "{ 2, 4, 8, 16 }")
  end)

  -- Array#pop
  -- -------------------------------------------------------------------

  test("rubik.pop(array) -> removed element or nil", function()
    local array = { 2, 4 }

    assert.equal(rubik.pop(array), 4)
    assert.equal(rubik.pop(array), 2)
    assert.equal(rubik.pop(array), nil)
  end)

  -- Array#shift
  -- -------------------------------------------------------------------

  test("rubik.shift(array) -> removed element or nil", function()
    local array = { 2, 4 }

    assert.equal(rubik.shift(array), 2)
    assert.equal(rubik.shift(array), 4)
    assert.equal(rubik.shift(array), nil)
  end)

  -- Array#delete_at (deleteAt)
  -- -------------------------------------------------------------------

  test("rubik.deleteAt(array, index) -> removed element or nil", function()
    local array = { 2, 4, 8, 16 }

    assert.equal(rubik.deleteAt(array, -2), 8)
    assert.equal(rubik.deleteAt(array, 2), 4)
    assert.equal(rubik.deleteAt(array, 100), nil)
  end)

  -- Array#delete
  -- -------------------------------------------------------------------

  test("rubik.delete(array, value) -> removed element or nil", function()
    local array = { 1, 2, 1, 2, 3, 3, 1, 1 }

    assert.equal(rubik.delete(array, 1), 1)
    assert.equal(inspect(array), "{ 2, 2, 3, 3 }")

    assert.equal(rubik.delete(array, 100), nil)
  end)

  -- Array#uniq
  -- -------------------------------------------------------------------

  test("rubik.uniq(array) -> new array", function()
    local numbers = { 1, 2, 1, 2, 3, 3, 1, 1 }

    assert.equal(inspect(rubik.uniq(numbers)), "{ 1, 2, 3 }")
  end)

  test("rubik.uniq(array, callback(element)) -> new array", function()
    local letters = { "a", "b", "bb", "c", "cc", "ccc" }

    local byLength = function(element)
      return element:len()
    end

    assert.equal(inspect(rubik.uniq(letters, byLength)), "{ \"a\", \"bb\", \"ccc\" }")
  end)
end)
