-- Enumerator Spec
-- ---------------------------------------------------------------------

local Enumerator = require("rubik.basic-object.object.enumerator")

-- ---------------------------------------------------------------------

describe("Enumerator", function()
  -- Initialize
  -- ---------------------------------------------------------------------

  before_each(function()
    fibonacci = Enumerator:new(function()
      local a = 1
      local b = 1

      return function(peek)
        local fibonacciNumber = a

        if not peek then
          a, b = b, a + b
        end

        return fibonacciNumber
      end
    end)
  end)

  -- Enumerator#new
  -- -------------------------------------------------------------------

  test("Enumerator:new(callback) -> new enumerator", function()
    assert.equal(fibonacci.class, Enumerator)
  end)

  -- Enumerator#next
  -- -------------------------------------------------------------------

  test("enumerator:next() -> value", function()
    fibonacci:next() -- 1
    fibonacci:next() -- 1
    fibonacci:next() -- 2
    fibonacci:next() -- 3

    assert.equal(fibonacci:next(), 5)
  end)

  -- Enumerator#peek
  -- -------------------------------------------------------------------

  test("enumerator:peek() -> value", function()
    fibonacci:next() -- 1
    fibonacci:next() -- 1
    fibonacci:next() -- 2

    fibonacci:peek() -- next would be 3
    fibonacci:peek() -- next would be 3
    fibonacci:peek() -- next would be 3

    assert.equal(fibonacci:next(), 3)
  end)

  -- Enumerator#rewind
  -- -------------------------------------------------------------------

  test("enumerator:peek() -> value", function()
    fibonacci:next() -- 1
    fibonacci:next() -- 1
    fibonacci:next() -- 2
    fibonacci:next() -- 3

    assert.equal(fibonacci:next(), 5)

    fibonacci:rewind()

    assert.equal(fibonacci:next(), 1)
  end)
end)
