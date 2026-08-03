-- Array Spec
-- ---------------------------------------------------------------------

local inspect = require("inspect")

local rubik = require("rubik")

-- Array
-- ---------------------------------------------------------------------

describe("Array", function()
  -- -------------------------------------------------------------------
  -- Class
  -- -------------------------------------------------------------------

  -- Array::fromLiteral
  -- -------------------------------------------------------------------

  describe("Array::fromLiteral", function()
    test("Array.fromLiteral(t) -> new array", function()
      local none = rubik.Array.fromLiteral({})
      local one = rubik.Array.fromLiteral({ 1 })
      local many = rubik.Array.fromLiteral({ 1, 2, 3, 4 })

      assert.equal(inspect(none:derubik()), "{}")
      assert.equal(inspect(one:derubik()), "{ 1 }")
      assert.equal(inspect(many:derubik()), "{ 1, 2, 3, 4 }")
    end)
  end)

  -- Array::new
  -- -------------------------------------------------------------------

  describe("Array::new", function()
    test("Array:new() -> new array", function()
      local empty = rubik.Array:new()

      assert.equal(inspect(empty:derubik()), "{}")
    end)

    test("Array:new(size) -> new array", function()
      local empty = rubik.Array:new(1000) -- Lua won't allow { nil, nil, ..., nil }

      assert.equal(inspect(empty:derubik()), "{}")
    end)

    test("Array:new(size, value) -> new array", function()
      local array = rubik.Array:new(4, 1)

      assert.equal(inspect(array:derubik()), "{ 1, 1, 1, 1 }")
    end)

    test("Array:new(size, _, callback(index)) -> new array", function()
      local array = rubik.Array:new(4, _, function(index)
        return math.pow(2, index)
      end)

      assert.equal(inspect(array:derubik()), "{ 2, 4, 8, 16 }")
    end)
  end)

  -- -------------------------------------------------------------------
  -- Instance
  -- -------------------------------------------------------------------

  -- Array#first (Array#take alias)
  -- -------------------------------------------------------------------

  describe("Array#first (Array#take alias)", function()
    test("array:first() -> element or nil", function()
      assert.equal(rubik.first({}), nil)
      assert.equal(rubik.first({ 2, 4, 8, 16 }), 2)
    end)

    test("array:first(n) -> new array", function()
      assert.equal(inspect(rubik.first({}, 0)), "{}")
      assert.equal(inspect(rubik.first({}, 1)), "{}")

      local array = { 2, 4, 8, 16 }

      assert.equal(inspect(rubik.first(array, 0)), "{}")
      assert.equal(inspect(rubik.first(array, 1)), "{ 2 }")
      assert.equal(inspect(rubik.first(array, 2)), "{ 2, 4 }")
      assert.equal(inspect(rubik.first(array, 100)), "{ 2, 4, 8, 16 }")
    end)
  end)

  -- Array#last
  -- -------------------------------------------------------------------

  describe("Array#last", function()
    test("array:last() -> element", function()
      assert.equal(rubik.last({}), nil)
      assert.equal(rubik.last({ 2, 4, 8, 16 }), 16)
    end)

    test("array:last(n) -> new array", function()
      assert.equal(inspect(rubik.last({}, 0)), "{}")
      assert.equal(inspect(rubik.last({}, 1)), "{}")

      local array = { 2, 4, 8, 16 }

      assert.equal(inspect(rubik.last(array, 0)), "{}")
      assert.equal(inspect(rubik.last(array, 1)), "{ 16 }")
      assert.equal(inspect(rubik.last(array, 2)), "{ 8, 16 }")
      assert.equal(inspect(rubik.last(array, 100)), "{ 2, 4, 8, 16 }")
    end)
  end)

  -- Array#drop
  -- -------------------------------------------------------------------

  describe("Array#drop", function()
    test("array:drop(n) -> new array", function()
      assert.equal(inspect(rubik.drop({}, 0)), "{}")
      assert.equal(inspect(rubik.drop({}, 1)), "{}")

      local array = { 2, 4, 8, 16 }

      assert.equal(inspect(rubik.drop(array, 0)), "{ 2, 4, 8, 16 }")
      assert.equal(inspect(rubik.drop(array, 1)), "{ 2, 4, 8 }")
      assert.equal(inspect(rubik.drop(array, 2)), "{ 2, 4 }")
      assert.equal(inspect(rubik.drop(array, 100)), "{}")
    end)
  end)

  -- Array#at [Array#__index metamethod]
  -- -------------------------------------------------------------------

  describe("Array#at", function()
    test("array:at(index) -> element", function()
      local array = rubik({ 2, 4, 8, 16 })

      assert.equal(array[1]:derubik(), 2)
      assert.equal(array[100]:derubik(), nil)
      assert.equal(array[-1]:derubik(), 16)
      assert.equal(array[-100]:derubik(), nil)
    end)
  end)

  -- Array#fetch
  -- -------------------------------------------------------------------

  describe("Array#fetch", function()
    test("array:fetch(index) -> element", function()
      local array = { 1, 2, 3, 4 }

      assert.equal(rubik.fetch(array, 1), 1)
      assert.equal(rubik.fetch(array, 0), nil)
      assert.equal(rubik.fetch(array, -1), 4)
    end)

    test("array:fetch(index, fallback) -> element", function()
      local array = { 1, 2, 3, 4 }

      assert.equal(rubik.fetch(array, 1, "not found"), 1)
      assert.equal(rubik.fetch(array, 0, "not found"), "not found")
      assert.equal(rubik.fetch(array, -1, "not found"), 4)
    end)

    test("array:fetch(index, _, callback(index)) -> element", function()
      local notFound = function(index)
        return "No element at " .. index
      end

      assert.equal(rubik.fetch({ 1, 2, 3, 4 }, 1, _, notFound), 1)
      assert.equal(rubik.fetch({ 1, 2, 3, 4 }, 0, _, notFound), "No element at 0")
    end)
  end)

  -- Array#slice
  -- -------------------------------------------------------------------

  describe("Array#slice", function()
    test("array:slice(index) -> element or nil", function()
      local array = { 2, 4, 8, 16, 32, 64, 128, 256 }

      assert.equal(rubik.slice(array, 2), 4)
      assert.equal(rubik.slice(array, 100), nil)
      assert.equal(rubik.slice(array, -1), 256)
      assert.equal(rubik.slice(array, -100), nil)
    end)

    test("array:slice(range) -> new array or nil", function()
      local array = { 2, 4, 8, 16, 32, 64, 128, 256 }

      assert.equal(inspect(rubik.slice(array, { 2, 2 })), "{ 4 }")
      assert.equal(inspect(rubik.slice(array, { 2, 4 })), "{ 4, 8, 16 }")
      assert.equal(inspect(rubik.slice(array, { 2, 100 })), "{ 4, 8, 16, 32, 64, 128, 256 }")
    end)

    test("array:slice(start, length) -> new array or nil", function()
      local array = { 2, 4, 8, 16, 32, 64, 128, 256 }

      assert.equal(inspect(rubik.slice(array, 2, 1)), "{ 4 }")
      assert.equal(inspect(rubik.slice(array, 2, 4)), "{ 4, 8, 16, 32 }")
      assert.equal(inspect(rubik.slice(array, 2, 100)), "{ 4, 8, 16, 32, 64, 128, 256 }")
    end)
  end)

  -- Array#size (Array#length alias)
  -- -------------------------------------------------------------------

  describe("Array#size (Array#length alias)", function()
    test("array:size() -> integer", function()
      assert.equal(rubik.size({}), 0)
      assert.equal(rubik.size({ 1, 2, 3, 4 }), 4)
    end)
  end)

  -- Array#count
  -- -------------------------------------------------------------------

  describe("Array#count", function()
    test("array:count() -> integer", function()
      assert.equal(rubik.count({}), 0)
      assert.equal(rubik.count({ 1, 2, 3, 4 }), 4)
    end)

    test("array:count(element) -> integer", function()
      local array = { 1, 1, 2, 3 }

      assert.equal(rubik.count(array, 1), 2)
      assert.equal(rubik.count(array, 2), 1)
      assert.equal(rubik.count(array, "3"), 0)
    end)

    test("array:count(_, callback) -> integer", function()
      assert.equal(rubik.count({ 1, 1, 2, 3 }, _, rubik["even?"]), 1)
    end)
  end)

  -- Array#empty?
  -- -------------------------------------------------------------------

  describe("Array#empty?", function()
    test("array[\":empty?\"]() -> true or false", function()
      local empty = {}
      local array = { 2, 4, 8, 16 }

      assert.equal(rubik["empty?"](empty), true)
      assert.equal(rubik["empty?"](array), false)
    end)
  end)

  -- Array#include?
  -- -------------------------------------------------------------------

  describe("Array#include?", function()
    test("array[\":include?\"](value) -> true or false", function()
      local array = { 2, 4, 8, 16 }

      assert.equal(rubik["include?"](array, 8), true)
      assert.equal(rubik["include?"](array, "8"), false)
    end)
  end)

  -- Array#push (Array#append alias)
  -- -------------------------------------------------------------------

  describe("Array#push (Array#append alias)", function()
    test("array:push(...) -> self", function()
      local array = rubik({})

      assert.equal(array:push(2), array)
      assert.equal(inspect(array:derubik()), "{ 2 }")

      assert.equal(array:push(4, 8, 16), array)
      assert.equal(inspect(array:derubik()), "{ 2, 4, 8, 16 }")
    end)
  end)

  -- Array#unshift (Array#prepend alias)
  -- -------------------------------------------------------------------

  describe("Array#unshift (Array#prepend alias)", function()
    test("array:unshift(...) -> self", function()
      local array = rubik({})

      assert.equal(array:unshift(16), array)
      assert.equal(inspect(array:derubik()), "{ 16 }")

      assert.equal(array:unshift(2, 4, 8), array)
      assert.equal(inspect(array:derubik()), "{ 2, 4, 8, 16 }")
    end)
  end)

  -- Array#insert
  -- -------------------------------------------------------------------

  describe("Array#insert", function()
    test("array:insert(index, ...) -> self", function()
      local array = rubik({})

      assert.equal(array:insert(1, 4), array)
      assert.equal(inspect(array:derubik()), "{ 4 }")

      assert.equal(array:insert(1, 2), array)
      assert.equal(inspect(array:derubik()), "{ 2, 4 }")

      assert.equal(array:insert(3, 8, 16), array)
      assert.equal(inspect(array:derubik()), "{ 2, 4, 8, 16 }")
    end)
  end)

  -- Array#pop
  -- -------------------------------------------------------------------

  describe("Array#pop", function()
    test("array:pop() -> element or nil", function()
      local array = rubik({ 2, 4 })

      assert.equal(array:pop():derubik(), 4)
      assert.equal(inspect(array:derubik()), "{ 2 }")

      assert.equal(array:pop():derubik(), 2)
      assert.equal(inspect(array:derubik()), "{}")

      assert.equal(array:pop():derubik(), nil)
      assert.equal(inspect(array:derubik()), "{}")
    end)
  end)

  -- Array#shift
  -- -------------------------------------------------------------------

  describe("Array#shift", function()
    test("array:shift() -> element or nil", function()
      local array = rubik({ 2, 4 })

      assert.equal(array:shift():derubik(), 2)
      assert.equal(inspect(array:derubik()), "{ 4 }")

      assert.equal(array:shift():derubik(), 4)
      assert.equal(inspect(array:derubik()), "{}")

      assert.equal(array:shift():derubik(), nil)
      assert.equal(inspect(array:derubik()), "{}")
    end)
  end)

  -- Array#delete_at
  -- -------------------------------------------------------------------

  describe("Array#delete_at", function()
    test("array:delete_at(index) -> element or nil", function()
      local array = rubik({ 2, 4, 8, 16 })

      assert.equal(array:delete_at(-2):derubik(), 8)
      assert.equal(inspect(array:derubik()), "{ 2, 4, 16 }")

      assert.equal(array:delete_at(2):derubik(), 4)
      assert.equal(inspect(array:derubik()), "{ 2, 16 }")

      assert.equal(array:delete_at(100):derubik(), nil)
      assert.equal(inspect(array:derubik()), "{ 2, 16 }")
    end)
  end)

  -- Array#delete
  -- -------------------------------------------------------------------

  describe("Array#delete", function()
    test("array:delete(value) -> value or nil", function()
      local array = rubik({ 1, 2, 1, 2, 3, 3, 1, 1 })

      assert.equal(array:delete(1):derubik(), 1)
      assert.equal(inspect(array:derubik()), "{ 2, 2, 3, 3 }")

      assert.equal(array:delete(1):derubik(), nil)
      assert.equal(inspect(array:derubik()), "{ 2, 2, 3, 3 }")
    end)
  end)

  -- Array#uniq
  -- -------------------------------------------------------------------

  describe("Array#uniq", function()
    test("array:uniq() -> new array", function()
      assert.equal(inspect(rubik.uniq({})), "{}")
      assert.equal(inspect(rubik.uniq({ 1, 1, 2, 2, 3, 3 })), "{ 1, 2, 3 }")
    end)

    test("array:uniq(callback(element)) -> new array", function()
      local letters = { "a", "bb", "ccc", "d", "ee", "fff" }

      local byLength = function(element)
        return element:len()
      end

      assert.equal(inspect(rubik.uniq(letters, byLength)), "{ \"a\", \"bb\", \"ccc\" }")
    end)
  end)

  -- Array#each
  -- -------------------------------------------------------------------

  describe("Array#each", function()
    test("array:each(callback(element)) -> self", function()
      local numbers = rubik({ 1, 2, 3, 4 })
      local squares = rubik({})

      local returns = numbers:each(function(number)
        squares:push(math.pow(number, 2))
      end)

      assert.equal(returns, numbers)

      assert.equal(inspect(numbers:derubik()), "{ 1, 2, 3, 4 }")
      assert.equal(inspect(squares:derubik()), "{ 1, 4, 9, 16 }")
    end)
  end)

  -- Array#reverse_each
  -- -------------------------------------------------------------------

  describe("Array#reverse_each", function()
    test("array:reverse_each(callback(element)) -> self", function()
      local numbers = rubik({ 1, 2, 3, 4 })
      local reverse = rubik({})

      local returns = numbers:reverse_each(function(number)
        reverse:push(number)
      end)

      assert.equal(returns, numbers)

      assert.equal(inspect(numbers:derubik()), "{ 1, 2, 3, 4 }")
      assert.equal(inspect(reverse:derubik()), "{ 4, 3, 2, 1 }")
    end)
  end)

  -- Array#each_index
  -- -------------------------------------------------------------------

  describe("Array#each_index", function()
    test("array:each_index(callback(index)) -> self", function()
      local numbers = rubik({ 2, 4, 8, 16 })
      local indexValuePairs = rubik({})

      local returns = numbers:each_index(function(index)
        indexValuePairs:push({ index, numbers:at(index):derubik() })
      end)

      assert.equal(returns, numbers)

      assert.equal(inspect(numbers:derubik()), "{ 2, 4, 8, 16 }")
      assert.equal(inspect(indexValuePairs:derubik()), "{ { 1, 2 }, { 2, 4 }, { 3, 8 }, { 4, 16 } }")
    end)
  end)

  -- Array#map (Array#collect alias)
  -- -------------------------------------------------------------------

  describe("Array#map (Array#collect alias)", function()
    test("array:map(callback(element)) -> new array", function()
      local squares = rubik.map({ 1, 2, 3, 4 }, function(number)
        return math.pow(number, 2)
      end)

      assert.equal(inspect(squares), "{ 1, 4, 9, 16 }")
    end)
  end)

  -- Array#select (Array#filter alias)
  -- -------------------------------------------------------------------

  describe("Array#select (Array#filter alias)", function()
    test("array:select(callback(element)) -> new array", function()
      local evenNumbers = rubik.select({ 1, 2, 3, 4 }, function(number)
        return (number % 2) == 0
      end)

      assert.equal(inspect(evenNumbers), "{ 2, 4 }")
    end)
  end)

  -- Array#keep_if
  -- -------------------------------------------------------------------

  describe("Array#keep_if", function()
    test("array:keep_if(callback(element)) -> self", function()
      local array = rubik({ 1, 2, 3, 4 })

      assert.equal(array:keep_if(rubik["even?"]), array)
      assert.equal(inspect(array:derubik()), "{ 2, 4 }")
    end)
  end)

  -- Array#reject
  -- -------------------------------------------------------------------

  describe("Array#reject", function()
    test("array:reject(callback(element)) -> new array", function()
      local oddNumbers = rubik.reject({ 1, 2, 3, 4 }, function(number)
        return (number % 2) == 0
      end)

      assert.equal(inspect(oddNumbers), "{ 1, 3 }")
    end)
  end)

  -- Array#delete_if
  -- -------------------------------------------------------------------

  describe("Array#delete_if", function()
    test("array:delete_if(callback(element)) -> self", function()
      local array = rubik({ 1, 2, 3, 4 })

      assert.equal(array:delete_if(rubik["even?"]), array)
      assert.equal(inspect(array:derubik()), "{ 1, 3 }")
    end)
  end)

  -- Array#all?
  -- -------------------------------------------------------------------

  describe("Array#all?", function()
    test("array[\":all?\"]() -> true or false", function()
      local empty = {}
      local tttt = { true, true, true, true }  -- true
      local ttft = { true, true, false, true } -- true false

      assert.equal(rubik["all?"](empty), true)
      assert.equal(rubik["all?"](tttt), true)
      assert.equal(rubik["all?"](ttft), false)
    end)

    test("array[\"all?\"](value) -> true or false", function()
      local empty = {}
      local oooo = { 1, 1, 1, 1 } -- one
      local oozo = { 1, 1, 0, 1 } -- one zero

      assert.equal(rubik["all?"](empty, 100), true)
      assert.equal(rubik["all?"](oooo, 1), true)
      assert.equal(rubik["all?"](oozo, 1), false)
    end)

    test("array[\"all?\"](_, callback(element)) -> true or false", function()
      local empty = {}
      local eeee = { 2, 2, 2, 2 } -- even
      local eeoe = { 2, 2, 3, 2 } -- even odd

      assert.equal(rubik["all?"](empty, _, rubik["even?"]), true)
      assert.equal(rubik["all?"](eeee, _, rubik["even?"]), true)
      assert.equal(rubik["all?"](eeoe, _, rubik["even?"]), false)
    end)
  end)

  -- Array#any?
  -- -------------------------------------------------------------------

  describe("Array#any?", function()
    test("array[\":any?\"]() -> true or false", function()
      local empty = {}
      local ffff = { false, false, false, false } -- false
      local fftf = { false, false, true, false }  -- false true

      assert.equal(rubik["any?"](empty), false)
      assert.equal(rubik["any?"](ffff), false)
      assert.equal(rubik["any?"](fftf), true)
    end)

    test("array[\"any?\"](value) -> true or false", function()
      local empty = {}
      local oozo = { 1, 1, 0, 1 } -- one zero

      assert.equal(rubik["any?"](empty, 100), false)
      assert.equal(rubik["any?"](oozo, 0), true)
      assert.equal(rubik["any?"](oozo, 100), false)
    end)

    test("array[\"any?\"](_, callback(element)) -> true or false", function()
      local empty = {}
      local oooo = { 3, 3, 3, 3 } -- odd
      local ooeo = { 3, 3, 2, 3 } -- odd even

      assert.equal(rubik["any?"](empty, _, rubik["even?"]), false)
      assert.equal(rubik["any?"](oooo, _, rubik["even?"]), false)
      assert.equal(rubik["any?"](ooeo, _, rubik["even?"]), true)
    end)
  end)

  -- Array#none?
  -- -------------------------------------------------------------------

  describe("Array#none?", function()
    test("array[\":none?\"]() -> true or false", function()
      local empty = {}
      local ffff = { false, false, false, false } -- false
      local ttft = { true, true, false, true }    -- true false

      assert.equal(rubik["none?"](empty), true)
      assert.equal(rubik["none?"](ffff), true)
      assert.equal(rubik["none?"](ttft), false)
    end)

    test("array[\"none?\"](value) -> true or false", function()
      local empty = {}
      local oozo = { 1, 1, 0, 1 } -- one zero

      assert.equal(rubik["none?"](empty, 100), true)
      assert.equal(rubik["none?"](oozo, 100), true)
      assert.equal(rubik["none?"](oozo, 0), false)
    end)

    test("array[\"none?\"](_, callback(element)) -> true or false", function()
      local empty = {}
      local oooo = { 3, 3, 3, 3 } -- odd
      local ooeo = { 3, 3, 2, 3 } -- odd even

      assert.equal(rubik["none?"](empty, _, rubik["even?"]), true)
      assert.equal(rubik["none?"](oooo, _, rubik["even?"]), true)
      assert.equal(rubik["none?"](ooeo, _, rubik["even?"]), false)
    end)
  end)

  -- Array#one?
  -- -------------------------------------------------------------------

  describe("Array#one?", function()
    test("array[\":one?\"]() -> true or false", function()
      local empty = {}
      local ffff = { false, false, false, false } -- none
      local fftf = { false, false, true, false }  -- one
      local tftf = { true, false, true, false }   -- more than one

      assert.equal(rubik["one?"](empty), false)
      assert.equal(rubik["one?"](ffff), false)
      assert.equal(rubik["one?"](fftf), true)
      assert.equal(rubik["one?"](tftf), false)
    end)

    test("array[\"one?\"](value) -> true or false", function()
      local empty = {}
      local zzzz = { 0, 0, 0, 0 } -- none
      local zzoz = { 0, 0, 1, 0 } -- one
      local ozoz = { 1, 0, 1, 0 } -- more than one

      assert.equal(rubik["one?"](empty, 100), false)
      assert.equal(rubik["one?"](zzzz, 1), false)
      assert.equal(rubik["one?"](zzoz, 1), true)
      assert.equal(rubik["one?"](ozoz, 1), false)
    end)

    test("array[\"one?\"](_, callback(element)) -> true or false", function()
      local empty = {}
      local oooo = { 3, 3, 3, 3 } -- none
      local ooeo = { 3, 3, 2, 3 } -- one
      local eoeo = { 2, 3, 2, 3 } -- more than one

      assert.equal(rubik["one?"](empty, _, rubik["even?"]), false)
      assert.equal(rubik["one?"](oooo, _, rubik["even?"]), false)
      assert.equal(rubik["one?"](ooeo, _, rubik["even?"]), true)
      assert.equal(rubik["one?"](eoeo, _, rubik["even?"]), false)
    end)
  end)

  -- Array#index (Array#find_index alias)
  -- -------------------------------------------------------------------

  describe("Array#index (Array#find_index alias)", function()
    test("array:index(value) -> integer or nil", function()
      local array = { 0, 0, 1, 1 }

      assert.equal(rubik.index(array, 1), 3)
      assert.equal(rubik.index(array, 100), nil)
    end)

    test("array:index(_, callback(element)) -> integer or nil", function()
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
  end)

  -- Array#rindex
  -- -------------------------------------------------------------------

  describe("Array#rindex", function()
    test("array:rindex(value) -> integer or nil", function()
      local array = { 0, 0, 1, 1 }

      assert.equal(rubik.rindex(array, 1), 4)
      assert.equal(rubik.rindex(array, 100), nil)
    end)

    test("array:rindex(_, callback(element)) -> integer or nil", function()
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
  end)

  -- Array#minmax
  -- -------------------------------------------------------------------

  describe("Array#minmax", function()
    test("array:minmax() -> new array", function()
      assert.equal(inspect(rubik.minmax({})), "{}")
      assert.equal(inspect(rubik.minmax({ 8, 4, 2, 1 })), "{ 1, 8 }")
    end)

    test("array:minmax(callback(a, b)) -> new array", function()
      local array = { "rubik", "minmax", "array", "callback", "a", "b", "min", "max" }

      local byLength = function(a, b)
        return rubik["<=>"](a:len(), b:len())
      end

      assert.equal(inspect(rubik.minmax(array, byLength)), "{ \"a\", \"callback\" }")
    end)
  end)

  -- Array#sort
  -- -------------------------------------------------------------------

  describe("Array#sort", function()
    test("array:sort() -> new array", function()
      local array = { 8, 4, 2, 1 }

      assert.equal(inspect(rubik.sort(array)), "{ 1, 2, 4, 8 }")
      assert.equal(inspect(array), "{ 8, 4, 2, 1 }")
    end)

    test("array:sort(callback) -> new array", function()
      local array = { 1, 2, 4, 8 }

      local reverse = function(a, b)
        return a > b
      end

      assert.equal(inspect(rubik.sort(array, reverse)), "{ 8, 4, 2, 1 }")
      assert.equal(inspect(array), "{ 1, 2, 4, 8 }")
    end)
  end)

  -- Array#reverse
  -- -------------------------------------------------------------------

  describe("Array#reverse", function()
    test("array:reverse() -> new array", function()
      assert.equal(inspect(rubik.reverse({ 1, 2, 3, 4 })), "{ 4, 3, 2, 1 }")
      assert.equal(inspect(rubik.reverse({ "a" })), "{ \"a\" }")
      assert.equal(inspect(rubik.reverse({})), "{}")
    end)
  end)

  -- Array#max
  -- -------------------------------------------------------------------

  describe("Array#max", function()
    test("array:max() -> element", function()
      local array = { 1, 1, 3, 2, 9, 4, 27, 8 }

      assert.equal(rubik.max(array), 27)
    end)

    test("array:max(n) -> new array", function()
      local array = { 1, 1, 3, 2, 9, 4, 27, 8 }

      assert.equal(inspect(rubik.max(array, 4)), "{ 27, 9, 8, 4 }")
    end)

    test("array:max(_, callback) -> element", function()
      local array = { "a", "bb", "ccc", "dddd" }

      local byLength = function(a, b)
        return a:len() < b:len()
      end

      assert.equal(rubik.max(array, _, byLength), "dddd")
    end)

    test("array:max(n, callback) -> new array", function()
      local array = { "a", "bb", "ccc", "dddd" }

      local byLength = function(a, b)
        return a:len() < b:len()
      end

      assert.equal(inspect(rubik.max(array, 2, byLength)), "{ \"dddd\", \"ccc\" }")
    end)
  end)

  -- Array#min
  -- -------------------------------------------------------------------

  describe("Array#min", function()
    test("array:min() -> element", function()
      local array = { 1, 1, 3, 2, 9, 4, 27, 8 }

      assert.equal(rubik.min(array), 1)
    end)

    test("array:min(n) -> new array", function()
      local array = { 1, 1, 3, 2, 9, 4, 27, 8 }

      assert.equal(inspect(rubik.min(array, 4)), "{ 1, 1, 2, 3 }")
    end)

    test("array:min(_, callback) -> element", function()
      local array = { "a", "bb", "ccc", "dddd" }

      local byLength = function(a, b)
        return a:len() < b:len()
      end

      assert.equal(rubik.min(array, _, byLength), "a")
    end)

    test("array:min(n, callback) -> new array", function()
      local array = { "a", "bb", "ccc", "dddd" }

      local byLength = function(a, b)
        return a:len() < b:len()
      end

      assert.equal(inspect(rubik.min(array, 2, byLength)), "{ \"a\", \"bb\" }")
    end)
  end)

  -- Array#assoc
  -- -------------------------------------------------------------------

  describe("Array#assoc", function()
    test("array:assoc(value) -> new array or nil", function()
      local array = { { 0, 0 }, { 0, 1 }, { 1, 0 }, { 1, 1 } }

      assert.equal(inspect(rubik.assoc(array, 1)), "{ 1, 0 }")
      assert.equal(rubik.assoc(array, 100), nil)
    end)
  end)

  -- Array#rassoc
  -- -------------------------------------------------------------------

  describe("Array#rassoc", function()
    test("array:rassoc(value) -> new array or nil", function()
      local array = { { 0, 0 }, { 0, 1 }, { 1, 0 }, { 1, 1 } }

      assert.equal(inspect(rubik.rassoc(array, 1)), "{ 0, 1 }")
      assert.equal(rubik.rassoc(array, 100), nil)
    end)
  end)

  -- Array#values_at
  -- -------------------------------------------------------------------

  describe("Array#values_at", function()
    test("array:values_at(...) -> new array", function()
      local array = { 2, 4, 8, 16 }

      assert.equal(inspect(rubik.values_at(array, 1, 4)), "{ 2, 16 }")
      assert.equal(inspect(rubik.values_at(array, { 1, 4 })), "{ 2, 4, 8, 16 }")
      assert.equal(inspect(rubik.values_at(array, 1, -1, 1, -1)), "{ 2, 16, 2, 16 }")

      assert.equal(inspect(rubik.values_at(array, 100, -100)), "{}")
    end)
  end)

  -- Array#dig
  -- -------------------------------------------------------------------

  describe("Array#dig", function()
    test("array:dig(...) -> element or nil", function()
      local array = { 1, 2, { 3, 4, { 5, 6, { 7, 8 } } } }

      assert.equal(inspect(rubik.dig(array, 3)), "{ 3, 4, { 5, 6, { 7, 8 } } }")
      assert.equal(inspect(rubik.dig(array, 3, -1)), "{ 5, 6, { 7, 8 } }")
      assert.equal(inspect(rubik.dig(array, 3, -1, 1)), "5")
      assert.equal(inspect(rubik.dig(array, 3, -1, 100)), "nil")
    end)
  end)

  -- Array#shuffle
  -- -------------------------------------------------------------------

  describe("Array#shuffle", function()
    test("array:shuffle() -> new array", function()
      local array = { 1, 2, 3, 4, 5, 6, 7, 8 }

      local shuffled = rubik.shuffle(array)

      assert.equal(#shuffled, #array)

      rubik.each(array, function(element)
        assert.equal(rubik["include?"](shuffled, element), true)
      end)
    end)

    test("array:shuffle(prng) -> new array", function()
      local array = { 1, 2, 3, 4, 5, 6, 7, 8 }

      local fauxShuffled = rubik.shuffle(array, function(max)
        return max -- faux PRNG
      end)

      assert.equal(#rubik.shuffle(array), #array)

      rubik.each(array, function(element)
        assert.equal(rubik["include?"](fauxShuffled, element), true)
      end)

      assert.equal(inspect(fauxShuffled), "{ 8, 7, 6, 5, 4, 3, 2, 1 }")
    end)
  end)

  -- Array#sample
  -- -------------------------------------------------------------------

  describe("Array#sample", function()
    test("array:sample() -> element", function()
      local array = { 1, 2, 3, 4, 5, 6, 7, 8 }

      assert.equal(rubik["include?"](array, rubik.sample(array)), true)
    end)

    test("array:sample(n) -> new array", function()
      local array = { 1, 2, 3, 4, 5, 6, 7, 8 }

      local sampled = rubik.sample(array, 100) -- sample size clamped at #array

      assert.equal(#sampled, #array)

      rubik.each(sampled, function(element)
        assert.equal(rubik["include?"](array, element), true)
      end)
    end)

    test("array:sample(_, prng) -> element", function()
      local array = { 1, 2, 3, 4, 5, 6, 7, 8 }

      local fauxSample = rubik.sample(array, _, function(max)
        return max
      end)

      assert.equal(fauxSample, 8)
    end)

    test("array:sample(n, prng) -> new array", function()
      local array = { 1, 2, 3, 4, 5, 6, 7, 8 }

      -- sample size clamped at #array
      local fauxSampled = rubik.sample(array, 100, function(max)
        return max
      end)

      assert.equal(#fauxSampled, #array)

      rubik.each(fauxSampled, function(element)
        assert.equal(rubik["include?"](array, element), true)
      end)

      assert.equal(inspect(fauxSampled), "{ 8, 7, 6, 5, 4, 3, 2, 1 }")
    end)
  end)

  -- Array#cycle
  -- -------------------------------------------------------------------

  describe("Array#cycle", function()
    test("array:cycle(count, callback) -> nil", function()
      local array = { 2, 4, 8, 16 }

      local numbers = {}
      local cycleNumbers = function(element)
        table.insert(numbers, element)
      end

      rubik.cycle(array, -1, cycleNumbers) -- none
      rubik.cycle(array, 0, cycleNumbers)  -- none

      rubik.cycle(array, 1, cycleNumbers)  -- once
      rubik.cycle(array, 2, cycleNumbers)  -- twice

      assert.equal(inspect(numbers), "{ 2, 4, 8, 16, 2, 4, 8, 16, 2, 4, 8, 16 }")
    end)
  end)

  -- Array#inspect (Array#to_s alias) [Array#__tostring metamethod]
  -- -------------------------------------------------------------------

  describe("Array#inspect", function()
    test("array:inspect() -> new string", function()
      assert.equal(rubik.inspect({}), "{}")
      assert.equal(rubik.inspect({ 1 }), "{ 1 }")
    end)
  end)

  -- Array#sum
  -- -------------------------------------------------------------------

  describe("Array#sum", function()
    test("array:sum() -> object", function()
      assert.equal(rubik.sum({ 1, 2, 3 }), 6)
    end)

    test("array:sum(init) -> object", function()
      assert.equal(rubik.sum({ 1, 2, 3 }, 100), 106)
    end)

    test("array:sum(init, callback) -> object", function()
      local square = function(x)
        return x ^ 2
      end

      assert.equal(rubik.sum({ 1, 2, 3 }, 0, square), 14)
      assert.equal(rubik.sum({ 1, 2, 3 }, 100, square), 114)
    end)
  end)
end)
