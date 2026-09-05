-- NilClass Spec
-- ---------------------------------------------------------------------

local inspect = require("inspect")

local rubik = require("rubik")

-- NilClass
-- ---------------------------------------------------------------------

describe("NilClass", function()
  -- -------------------------------------------------------------------
  -- Instance
  -- -------------------------------------------------------------------

  -- NilClass#to_a
  -- -------------------------------------------------------------------

  describe("NilClass#to_a", function()
    test("instance:to_a() -> Array {}", function()
      local array = rubik(nil):to_a()

      assert.equal(array.class.name, "Array")
      assert.equal(inspect(array:derubik()), "{}")
    end)
  end)

  -- NilClass#to_f
  -- -------------------------------------------------------------------

  describe("NilClass#to_f", function()
    test("instance:to_f() -> Float 0.0", function()
      local float = rubik(nil):to_f()

      assert.equal(float.class.name, "Float")
      assert.equal(float:derubik(), 0)
    end)
  end)

  -- NilClass#to_i
  -- -------------------------------------------------------------------

  describe("NilClass#to_i", function()
    test("instance:to_i() -> Integer 0", function()
      local integer = rubik(nil):to_i()

      assert.equal(integer.class.name, "Integer")
      assert.equal(integer:derubik(), 0)
    end)
  end)

  -- NilClass#to_s
  -- -------------------------------------------------------------------

  describe("NilClass#to_s", function()
    test("instance:to_s() -> String \"\"", function()
      local s = rubik(nil):to_s()

      assert.equal(s.class.name, "String")
      assert.equal(s:derubik(), "")
    end)
  end)

  -- NilClass#to_h
  -- -------------------------------------------------------------------

  describe("NilClass#to_h", function()
    test("instance:to_h() -> Hash {}", function()
      local hash = rubik(nil):to_h()

      assert.equal(hash.class.name, "Hash")
      assert.equal(inspect(hash:derubik()), "{}")
    end)
  end)
end)
