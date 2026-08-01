-- Enumerator Spec
-- ---------------------------------------------------------------------

local Enumerator = require("rubik.basic-object.object.enumerator")

-- ---------------------------------------------------------------------

describe("Enumerator", function()
  -- -------------------------------------------------------------------
  -- Setup
  -- -------------------------------------------------------------------

  -- Initialize
  -- ---------------------------------------------------------------------

  before_each(function()
    fibonacci = Enumerator:new(_, function()
      local a = 1
      local b = 1

      while true do
        coroutine.yield(a)

        a, b = b, a + b
      end
    end)
  end)

  -- -------------------------------------------------------------------
  -- Class
  -- -------------------------------------------------------------------

  -- Enumerator#new
  -- -------------------------------------------------------------------

  test("Enumerator:new(_, callback) -> new enumerator", function()
    assert.equal(fibonacci.class, Enumerator)
  end)

  -- Enumerator#produce
  -- -------------------------------------------------------------------

  test("Enumerator.produce(initial, block(previous)) -> new enumerator", function()
    local numbers = Enumerator.produce(1, function(previous)
      return previous + 1
    end)

    assert.equal(numbers:next(), 1)
    assert.equal(numbers:next(), 2)
    assert.equal(numbers:next(), 3)
  end)

  -- -------------------------------------------------------------------
  -- Instance
  -- -------------------------------------------------------------------

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

  test("enumerator:rewind() -> self", function()
    fibonacci:next() -- 1
    fibonacci:next() -- 1
    fibonacci:next() -- 2
    fibonacci:next() -- 3

    assert.equal(fibonacci:rewind(), fibonacci)

    assert.equal(fibonacci:next(), 1)
  end)
end)
