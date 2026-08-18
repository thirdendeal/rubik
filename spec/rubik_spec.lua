-- Rubik Spec
-- ---------------------------------------------------------------------

local inspect = require("inspect")

local rubik = require("rubik")

-- Rubik
-- ---------------------------------------------------------------------

describe("Rubik", function()
  -- Rubik::fromLiteral [Rubik::__call metamethod]
  -- -------------------------------------------------------------------

  test("rubik(value) -> new object", function()
    assert.equal(rubik({}).class.name, "Array")
    assert.equal(rubik(false).class.name, "FalseClass")
    assert.equal(rubik(1.5).class.name, "Float")
    assert.equal(rubik(1.0).class.name, "Integer") -- 1.0 and 1 are equal in Lua
    assert.equal(rubik(1).class.name, "Integer")
    assert.equal(rubik(nil).class.name, "NilClass")
    assert.equal(rubik("").class.name, "String")
    assert.equal(rubik(true).class.name, "TrueClass")

    local co = coroutine.create(function() end)

    assert.equal(rubik(co).class.name, "BasicObject") -- fallback
  end)

  test("rubik(value) -> new object (chain)", function()
    local pipeline = rubik({ 1, 2, 3, 4 })
        :filter(rubik["odd?"])                                -- Array: { 1, 3 }
        :map(function(number) return math.pow(number, 3) end) -- Array: { 1, 27 }
        :sum()                                                -- Integer: 28
        [":odd?"]()                                           -- FalseClass: false
        :derubik()                                            -- false

    assert.equal(pipeline, false)
  end)

  -- Rubik::in_and_out [Rubik::__index metamethod]
  -- -------------------------------------------------------------------

  test("rubik.in_and_out(recipe, method, ...) -> new value", function()
    local array = { 4, 3, 2, 1 }

    assert.equal(rubik.in_and_out(array, "max"), rubik(array):max():derubik())
  end)

  -- Rubik::["<=>"]
  -- -------------------------------------------------------------------

  test("rubik[\"<=>\"](a, b) -> 1, 0 or -1", function()
    assert.equal(rubik["<=>"](4, 2), 1)
    assert.equal(rubik["<=>"](4, 4), 0)
    assert.equal(rubik["<=>"](2, 4), -1)
  end)

  -- Rubik::patch_quoted_methods
  -- -------------------------------------------------------------------

  test("rubik.patch_quoted_methods(object, methods) -> nil", function()
    local counter = { tally = 0, ["increase"] = function(self)
      self.tally = self.tally + 1
    end }

    counter.increase(counter)

    assert.equal(counter.tally, 1)

    rubik.patch_quoted_methods(counter, { "increase" })
    counter[":increase"]()

    assert.equal(counter.tally, 2)
  end)

  -- Rubik::already?
  -- -------------------------------------------------------------------

  test("rubik[\"already?\"](value) -> true or false", function()
    local t = {}
    local emptyArray = rubik({})

    assert.equal(rubik["already?"](t), false)
    assert.equal(rubik["already?"](emptyArray), true)

    local number = 1
    local integer = rubik(1)

    assert.equal(rubik["already?"](number), false)
    assert.equal(rubik["already?"](integer), true)
  end)
end)
