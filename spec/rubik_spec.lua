-- Rubik Test
-- ---------------------------------------------------------------------

local inspect = require("inspect")

local rubik = require("../rubik")

-- ---------------------------------------------------------------------
-- Array
-- ---------------------------------------------------------------------

describe("Array", function()
  -- Array#newArray
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

  -- Array#empty?
  -- -------------------------------------------------------------------

  test("rubik[\"empty?\"](array) -> true or false", function()
    local array = { 2, 4, 8, 16 }
    assert.equal(rubik["empty?"](array), false)

    local empty = {}
    assert.equal(rubik["empty?"](empty), true)
  end)

  -- Array#include?
  -- -------------------------------------------------------------------

  test("rubik[\"include?\"](array, value) -> true or false", function()
    local array = { 2, 4, 8, 16 }

    assert.equal(rubik["include?"](array, 8), true)
    assert.equal(rubik["include?"](array, "8"), false)
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

  -- Array#deleteAt
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

  -- Array#each
  -- -------------------------------------------------------------------

  test("rubik.each(array, callback(element)) -> input array", function()
    local numbers = { 1, 2, 3, 4 }

    local squares = {}
    local each = rubik.each(numbers, function(number)
      rubik.push(squares, math.pow(number, 2))
    end)

    assert.equal(inspect(each), "{ 1, 2, 3, 4 }")
    assert.equal(inspect(squares), "{ 1, 4, 9, 16 }")
  end)

  -- Array#reverseEach
  -- -------------------------------------------------------------------

  test("rubik.reverseEach(array, callback(element)) -> input array", function()
    local array = { 1, 2, 3, 4 }

    local reverse = {}
    local each = rubik.reverseEach(array, function(number)
      rubik.push(reverse, number)
    end)

    assert.equal(inspect(each), "{ 1, 2, 3, 4 }")
    assert.equal(inspect(reverse), "{ 4, 3, 2, 1 }")
  end)

  -- Array#eachIndex
  -- -------------------------------------------------------------------

  test("rubik.eachIndex(array, callback(index)) -> input array", function()
    local numbers = { 2, 4, 8, 16 }

    local pairs = {}
    local eachIndex = rubik.eachIndex(numbers, function(index)
      rubik.push(pairs, { index, numbers[index] })
    end)

    assert.equal(inspect(eachIndex), "{ 2, 4, 8, 16 }")
    assert.equal(inspect(pairs), "{ { 1, 2 }, { 2, 4 }, { 3, 8 }, { 4, 16 } }")
  end)

  -- Array#map
  -- -------------------------------------------------------------------

  test("rubik.map(array, callback(element)) -> new array", function()
    local numbers = { 1, 2, 3, 4 }

    local squares = rubik.map(numbers, function(number)
      return math.pow(number, 2)
    end)

    assert.equal(inspect(squares), "{ 1, 4, 9, 16 }")
  end)

  -- Array#select
  -- -------------------------------------------------------------------

  test("rubik.select(array, callback(element)) -> new array", function()
    local array = { 1, 2, 3, 4 }

    local evenNumbers = rubik.select(array, function(number)
      return (number % 2) == 0
    end)

    assert.equal(inspect(evenNumbers), "{ 2, 4 }")
  end)

  -- Array#keepIf
  -- -------------------------------------------------------------------

  test("rubik.keepIf(array, callback(element)) -> input array", function()
    local array = { 1, 2, 3, 4 }

    rubik.keepIf(array, function(number)
      return (number % 2) == 0
    end)

    assert.equal(inspect(array), "{ 2, 4 }")
  end)

  -- Array#reject
  -- -------------------------------------------------------------------

  test("rubik.reject(array, callback(element)) -> new array", function()
    local array = { 1, 2, 3, 4 }

    local oddNumbers = rubik.reject(array, function(number)
      return (number % 2) == 0
    end)

    assert.equal(inspect(oddNumbers), "{ 1, 3 }")
  end)

  -- Array#deleteIf
  -- -------------------------------------------------------------------

  test("rubik.deleteIf(array, callback(element)) -> input array", function()
    local array = { 1, 2, 3, 4 }

    rubik.deleteIf(array, function(number)
      return (number % 2) == 0
    end)

    assert.equal(inspect(array), "{ 1, 3 }")
  end)

  -- Array#all?
  -- -------------------------------------------------------------------

  test("rubik[\"all?\"](array) -> true or false", function()
    local empty = {}
    local tttt = { true, true, true, true }  -- true
    local ttft = { true, true, false, true } -- true false

    assert.equal(rubik["all?"](empty), true)
    assert.equal(rubik["all?"](tttt), true)
    assert.equal(rubik["all?"](ttft), false)
  end)

  test("rubik[\"all?\"](array, value) -> true or false", function()
    local empty = {}
    local oooo = { 1, 1, 1, 1 } -- one
    local oozo = { 1, 1, 0, 1 } -- one zero

    assert.equal(rubik["all?"](empty, 100), true)
    assert.equal(rubik["all?"](oooo, 1), true)
    assert.equal(rubik["all?"](oozo, 1), false)
  end)

  test("rubik[\"all?\"](array, _, callback(element)) -> true or false", function()
    local empty = {}
    local eeee = { 2, 2, 2, 2 } -- even
    local eeoe = { 2, 2, 3, 2 } -- even odd

    local isEven = function(element)
      return (element % 2) == 0
    end

    assert.equal(rubik["all?"](empty, _, isEven), true)
    assert.equal(rubik["all?"](eeee, _, isEven), true)
    assert.equal(rubik["all?"](eeoe, _, isEven), false)
  end)

  -- Array#any?
  -- -------------------------------------------------------------------

  test("rubik[\"any?\"](array) -> true or false", function()
    local empty = {}
    local ffff = { false, false, false, false } -- false
    local fftf = { false, false, true, false }  -- false true

    assert.equal(rubik["any?"](empty), false)
    assert.equal(rubik["any?"](ffff), false)
    assert.equal(rubik["any?"](fftf), true)
  end)

  test("rubik[\"any?\"](array, value) -> true or false", function()
    local empty = {}
    local oozo = { 1, 1, 0, 1 } -- one zero

    assert.equal(rubik["any?"](empty, 100), false)
    assert.equal(rubik["any?"](oozo, 0), true)
    assert.equal(rubik["any?"](oozo, 100), false)
  end)

  test("rubik[\"any?\"](array, _, callback(element)) -> true or false", function()
    local empty = {}
    local oooo = { 3, 3, 3, 3 } -- odd
    local ooeo = { 3, 3, 2, 3 } -- odd even

    local isEven = function(element)
      return (element % 2) == 0
    end

    assert.equal(rubik["any?"](empty, _, isEven), false)
    assert.equal(rubik["any?"](oooo, _, isEven), false)
    assert.equal(rubik["any?"](ooeo, _, isEven), true)
  end)

  -- Array#none?
  -- -------------------------------------------------------------------

  test("rubik[\"none?\"](array) -> true or false", function()
    local empty = {}
    local ffff = { false, false, false, false } -- false
    local ttft = { true, true, false, true }    -- true false

    assert.equal(rubik["none?"](empty), true)
    assert.equal(rubik["none?"](ffff), true)
    assert.equal(rubik["none?"](ttft), false)
  end)

  test("rubik[\"none?\"](array, value) -> true or false", function()
    local empty = {}
    local oozo = { 1, 1, 0, 1 } -- one zero

    assert.equal(rubik["none?"](empty, 100), true)
    assert.equal(rubik["none?"](oozo, 100), true)
    assert.equal(rubik["none?"](oozo, 0), false)
  end)

  test("rubik[\"none?\"](array, _, callback(element)) -> true or false", function()
    local empty = {}
    local oooo = { 3, 3, 3, 3 } -- odd
    local ooeo = { 3, 3, 2, 3 } -- odd even

    local isEven = function(element)
      return (element % 2) == 0
    end

    assert.equal(rubik["none?"](empty, _, isEven), true)
    assert.equal(rubik["none?"](oooo, _, isEven), true)
    assert.equal(rubik["none?"](ooeo, _, isEven), false)
  end)

  -- Array#one?
  -- -------------------------------------------------------------------

  test("rubik[\"one?\"](array) -> true or false", function()
    local empty = {}
    local ffff = { false, false, false, false } -- none
    local fftf = { false, false, true, false }  -- one
    local tftf = { true, false, true, false }   -- more than one

    assert.equal(rubik["one?"](empty), false)
    assert.equal(rubik["one?"](ffff), false)
    assert.equal(rubik["one?"](fftf), true)
    assert.equal(rubik["one?"](tftf), false)
  end)

  test("rubik[\"one?\"](array, value) -> true or false", function()
    local empty = {}
    local zzzz = { 0, 0, 0, 0 } -- none
    local zzoz = { 0, 0, 1, 0 } -- one
    local ozoz = { 1, 0, 1, 0 } -- more than one

    assert.equal(rubik["one?"](empty, 100), false)
    assert.equal(rubik["one?"](zzzz, 1), false)
    assert.equal(rubik["one?"](zzoz, 1), true)
    assert.equal(rubik["one?"](ozoz, 1), false)
  end)

  test("rubik[\"one?\"](array, _, callback(element)) -> true or false", function()
    local empty = {}
    local oooo = { 3, 3, 3, 3 } -- none
    local ooeo = { 3, 3, 2, 3 } -- one
    local eoeo = { 2, 3, 2, 3 } -- more than one

    local isEven = function(element)
      return (element % 2) == 0
    end

    assert.equal(rubik["one?"](empty, _, isEven), false)
    assert.equal(rubik["one?"](oooo, _, isEven), false)
    assert.equal(rubik["one?"](ooeo, _, isEven), true)
    assert.equal(rubik["one?"](eoeo, _, isEven), false)
  end)

  -- Array#index
  -- -------------------------------------------------------------------

  test("rubik.index(array, value) -> integer or nil", function()
    local array = { 0, 0, 1, 1 }

    assert.equal(rubik.index(array, 1), 3)
    assert.equal(rubik.index(array, 100), nil)
  end)

  test("rubik.index(array, _, callback(element)) -> integer or nil", function()
    local array = { 2, 4, 8, 16 }

    local greaterThanFive = function(element)
      return element > 5
    end

    local negative = function(element)
      return element < 0
    end

    assert.equal(rubik.index(array, _, greaterThanFive), 3)
    assert.equal(rubik.index(array, _, negative), nil)
  end)

  -- Array#rindex
  -- -------------------------------------------------------------------

  test("rubik.rindex(array, value) -> integer or nil", function()
    local array = { 0, 0, 1, 1 }

    assert.equal(rubik.rindex(array, 1), 4)
    assert.equal(rubik.rindex(array, 100), nil)
  end)

  test("rubik.rindex(array, _, callback(element)) -> integer or nil", function()
    local array = { 2, 4, 8, 16 }

    local greaterThanFive = function(element)
      return element > 5
    end

    local negative = function(element)
      return element < 0
    end

    assert.equal(rubik.rindex(array, _, greaterThanFive), 4)
    assert.equal(rubik.rindex(array, _, negative), nil)
  end)

  -- Array#minmax
  -- -------------------------------------------------------------------

  test("rubik.minmax(array) -> {} or { min, max }", function()
    local empty = {}
    local array = { 8, 4, 2, 1 }

    assert.equal(inspect(rubik.minmax(empty)), "{}")
    assert.equal(inspect(rubik.minmax(array)), "{ 1, 8 }")
  end)

  test("rubik.minmax(array, callback(a, b)) -> {} or { min, max }", function()
    local array = { "rubik", "minmax", "array", "callback", "a", "b", "min", "max" }

    local byLength = function(a, b)
      return rubik._spaceshipOperator(a:len(), b:len())
    end

    assert.equal(inspect(rubik.minmax(array, byLength)), "{ \"a\", \"callback\" }")
  end)
end)
