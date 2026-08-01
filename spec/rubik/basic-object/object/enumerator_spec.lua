-- Enumerator Spec
-- ---------------------------------------------------------------------

local Enumerator = require("rubik.basic-object.object.enumerator")

-- ---------------------------------------------------------------------

describe("Enumerator", function()
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

  -- Enumerator#new
  -- -------------------------------------------------------------------

  test("Enumerator:new(_, callback) -> new enumerator", function()
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

  test("enumerator:rewind() -> self", function()
    fibonacci:next() -- 1
    fibonacci:next() -- 1
    fibonacci:next() -- 2
    fibonacci:next() -- 3

    assert.equal(fibonacci:rewind(), fibonacci)

    assert.equal(fibonacci:next(), 1)
  end)
end)
