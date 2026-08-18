-- Hash Spec
-- ---------------------------------------------------------------------

local inspect = require("inspect")

local rubik = require("rubik")

-- Hash
-- ---------------------------------------------------------------------

describe("Hash", function()
  -- -------------------------------------------------------------------
  -- Class
  -- -------------------------------------------------------------------

  -- Hash::fromLiteral
  -- -------------------------------------------------------------------

  describe("Hash::fromLiteral", function()
    test("Hash.fromLiteral(t) -> new hash", function()
      local apple = rubik.Hash.fromLiteral({ fruit = "apple" })

      assert.equal(apple["fruit"]:derubik(), "apple")
    end)
  end)

  -- -------------------------------------------------------------------
  -- Instance
  -- -------------------------------------------------------------------

  -- Hash#[]
  -- -------------------------------------------------------------------

  describe("Hash#[]", function()
    test("hash[] -> value", function()
      local hash = rubik({ fruit = "apple" })

      assert.equal(hash["fruit"]:derubik(), "apple")
    end)
  end)

  -- Hash#store
  -- -------------------------------------------------------------------

  describe("Hash#store", function()
    test("hash:store(key, value) -> value", function()
      local hash = rubik({ fruit = "apple" })

      assert.equal(hash:store("number", 2):derubik(), 2)
      assert.equal(hash["number"]:derubik(), 2)
    end)
  end)

  -- Hash#delete
  -- -------------------------------------------------------------------

  describe("Hash#delete", function()
    test("hash:delete(key) -> value or nil", function()
      local hash = rubik({ fruit = "apple" })

      assert.equal(hash:delete("table"):derubik(), nil)

      assert.equal(hash:delete("fruit"):derubik(), "apple")
      assert.equal(hash:delete("fruit"):derubik(), nil)
    end)
  end)

  -- Hash#keys
  -- -------------------------------------------------------------------

  describe("Hash#keys", function()
    test("hash:keys() -> array", function()
      local hash = rubik({ fruit = "apple" })

      hash:store("tool", "hammer")
      hash:store("debugger", "gdb")

      hash:delete("tool")

      assert.equal(inspect(hash:keys():derubik()), "{ \"fruit\", \"debugger\" }")
    end)
  end)

  -- Hash#values
  -- -------------------------------------------------------------------

  describe("Hash#values", function()
    test("hash:values() -> array", function()
      local hash = rubik({ fruit = "apple" })

      hash:store("tool", "hammer")
      hash:store("debugger", "gdb")

      hash:delete("tool")

      assert.equal(inspect(hash:values():derubik()), "{ \"apple\", \"gdb\" }")
    end)
  end)

  -- Hash#size
  -- -------------------------------------------------------------------

  describe("Hash#size", function()
    test("hash:size() -> integer", function()
      local hash = rubik.Hash.fromLiteral({})

      assert.equal(hash:size():derubik(), 0)

      hash:store("first", "mario")
      hash:store("second", "luigi")

      assert.equal(hash:size():derubik(), 2)

      hash:delete("first")

      assert.equal(hash:size():derubik(), 1)
    end)
  end)

  -- Hash#empty?
  -- -------------------------------------------------------------------

  describe("Hash#empty?", function()
    test("hash[\":empty?\"]() -> true or false", function()
      local hash = rubik.Hash.fromLiteral({})
      assert.equal(hash[":empty?"]():derubik(), true)

      hash:store(1, "one")
      assert.equal(hash[":empty?"]():derubik(), false)

      hash:delete(1)
      assert.equal(hash[":empty?"]():derubik(), true)
    end)
  end)
end)
