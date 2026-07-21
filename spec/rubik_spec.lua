-- Rubik Spec
-- ---------------------------------------------------------------------

local inspect = require("inspect")

local rubik = require("rubik")

-- Rubik
-- ---------------------------------------------------------------------

describe("Rubik", function()
  -- Rubik::wrap [Rubik::__call metamethod]
  -- -------------------------------------------------------------------

  test("rubik.wrap(recipe) -> new object", function()
    assert.equal(rubik.wrap({ 1 }).class.name, "Array")
    assert.equal(rubik.wrap(1).class.name, "Integer")
  end)

  test("rubik(...) chain", function()
    local evenCubes = rubik({ 1, 2, 3, 4 })
        :filter(function(x) return x % 2 == 0 end)
        :map(function(x) return math.pow(x, 3) end)
        :derubik()

    assert.equal(inspect(evenCubes), "{ 8, 64 }")
  end)

  -- Rubik::in_and_out [Rubik::__index metamethod]
  -- -------------------------------------------------------------------

  test("rubik.in_and_out(recipe, method, ...) -> new value", function()
    local array = { 4, 3, 2, 1 }

    assert.equal(rubik.in_and_out(array, "max"), rubik(array):max():unwrap())
  end)

  -- Rubik::["<=>"]
  -- -------------------------------------------------------------------

  test("rubik[\"<=>\"](a, b) -> 1, 0 or -1", function()
    assert.equal(rubik["<=>"](4, 2), 1)
    assert.equal(rubik["<=>"](4, 4), 0)
    assert.equal(rubik["<=>"](2, 4), -1)
  end)

  -- Rubik::patch_quote_methods
  -- -------------------------------------------------------------------

  test("rubik.patch_quote_methods(object, methods) -> nil", function()
    local counter = {
      tally = 0,
      ["increase"] = function(self)
        self.tally = self.tally + 1
      end
    }

    counter.increase(counter)

    assert.equal(counter.tally, 1)

    rubik.patch_quote_methods(counter, { "increase" })
    counter[":increase"]()

    assert.equal(counter.tally, 2)
  end)
end)
