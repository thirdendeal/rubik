-- Enumerator Spec
-- ---------------------------------------------------------------------

local inspect = require("inspect")

local rubik = require("rubik")

-- Enumerator
-- ---------------------------------------------------------------------

describe("Enumerator", function()
  -- -------------------------------------------------------------------
  -- Class
  -- -------------------------------------------------------------------

  -- Enumerator#new
  -- -------------------------------------------------------------------

  describe("Enumerator::new", function()
    test("Enumerator:new(_, block) -> new enumerator", function()
      local e = rubik.Enumerator:new(_, function()
        coroutine.yield(1)
        coroutine.yield(2)
        coroutine.yield(3)

        -- implicit last value: nil
      end)

      assert.equal(e:next():derubik(), 1)
      assert.equal(e:next():derubik(), 2)
      assert.equal(e:next():derubik(), 3)
      assert.equal(e:next():derubik(), nil)
    end)
  end)

  -- Enumerator#produce
  -- -------------------------------------------------------------------

  describe("Enumerator::produce", function()
    test("Enumerator.produce(initial, block(previous)) -> new enumerator", function()
      local sequence = rubik.Enumerator.produce(2, function(previous)
        return previous + 2
      end)

      assert.equal(sequence:next():derubik(), 2) -- inifinite sequence
      assert.equal(sequence:next():derubik(), 4)
      assert.equal(sequence:next():derubik(), 6)
    end)
  end)

  -- -------------------------------------------------------------------
  -- Instance
  -- -------------------------------------------------------------------

  -- Enumerator#next
  -- -------------------------------------------------------------------

  describe("Enumerator#next", function()
    test("enumerator:next() -> object", function()
      local e = rubik.Enumerator:new(_, function()
        coroutine.yield(1)
        coroutine.yield(2)
        coroutine.yield(nil)

        return 3 -- explicit last value
      end)

      assert.equal(e:next():derubik(), 1)
      assert.equal(e:next():derubik(), 2)
      assert.equal(e:next():derubik(), nil)
      assert.equal(e:next():derubik(), 3)

      local success, _ = pcall(function() e:next() end) -- throws StopIteration error

      assert.equal(success, false)
    end)
  end)

  -- Enumerator#next_values
  -- -------------------------------------------------------------------

  describe("Enumerator#next_values", function()
    test("enumerator:next_values() -> new array", function()
      local e = rubik.Enumerator:new(_, function()
        coroutine.yield(1)
        coroutine.yield({ 2 })

        -- implicit last value: nil
      end)

      assert.equal(inspect(e:next_values():derubik()), "{ 1 }")
      assert.equal(inspect(e:next_values():derubik()), "{ { 2 } }")
      assert.equal(inspect(e:next_values():derubik()), "{}")
    end)
  end)

  -- Enumerator#peek
  -- -------------------------------------------------------------------

  describe("Enumerator#peek", function()
    test("enumerator:peek() -> object", function()
      local e = rubik.Enumerator:new(_, function()
        coroutine.yield(1)
        coroutine.yield(2)
        coroutine.yield(nil)

        return 3 -- explicit last value
      end)

      assert.equal(e:next():derubik(), 1)
      assert.equal(e:next():derubik(), 2)
      assert.equal(e:next():derubik(), nil)

      assert.equal(e:peek():derubik(), 3) -- next is 3
      assert.equal(e:peek():derubik(), 3) -- next is 3
      assert.equal(e:peek():derubik(), 3) -- next is 3

      assert.equal(e:next():derubik(), 3)

      local success, _ = pcall(function() e:peek() end) -- throws StopIteration error

      assert.equal(success, false)
    end)
  end)

  -- Enumerator#peek_values
  -- -------------------------------------------------------------------

  describe("Enumerator#peek_values", function()
    test("enumerator:peek_values() -> new array", function()
      local e = rubik.Enumerator:new(_, function()
        coroutine.yield(1)
        coroutine.yield({ 2 })

        -- implicit last value: nil
      end)

      assert.equal(inspect(e:peek_values():derubik()), "{ 1 }")
      assert.equal(inspect(e:peek_values():derubik()), "{ 1 }")

      e:next()

      assert.equal(inspect(e:peek_values():derubik()), "{ { 2 } }")
      assert.equal(inspect(e:peek_values():derubik()), "{ { 2 } }")

      e:next()

      assert.equal(inspect(e:peek_values():derubik()), "{}")
      assert.equal(inspect(e:peek_values():derubik()), "{}")
    end)
  end)

  -- Enumerator#rewind
  -- -------------------------------------------------------------------

  describe("Enumerator#rewind", function()
    test("enumerator:rewind() -> self", function()
      local fibonacci = rubik.Enumerator:new(_, function()
        local a = 1
        local b = 1

        while true do
          coroutine.yield(a)

          a, b = b, a + b
        end
      end)

      assert.equal(fibonacci:next():derubik(), 1)
      assert.equal(fibonacci:next():derubik(), 1)
      assert.equal(fibonacci:next():derubik(), 2)
      assert.equal(fibonacci:next():derubik(), 3)
      assert.equal(fibonacci:next():derubik(), 5)

      assert.equal(fibonacci:rewind(), fibonacci)

      assert.equal(fibonacci:next():derubik(), 1)
    end)
  end)
end)
