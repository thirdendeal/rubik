-- String Spec
-- ---------------------------------------------------------------------

local inspect = require("inspect")

local rubik = require("rubik")

-- String
-- ---------------------------------------------------------------------

describe("String", function()
  -- -------------------------------------------------------------------
  -- Class
  -- -------------------------------------------------------------------

  -- String::wrap
  -- -------------------------------------------------------------------

  describe("String::wrap", function()
    test("String.wrap(value) -> new string", function()
      local apple = rubik.String.wrap("apple")

      assert.equal(apple:unwrap(), "apple")
    end)
  end)

  -- -------------------------------------------------------------------
  -- Instance
  -- -------------------------------------------------------------------

  -- String#even?
  -- -------------------------------------------------------------------

  describe("String#empty?", function()
    test("string[\":empty?\"]() -> true or false", function()
      assert.equal(rubik["empty?"]("non-zero length string"), false)
      assert.equal(rubik["empty?"](""), true)
    end)
  end)

  -- String#end_with?
  -- -------------------------------------------------------------------

  describe("String#end_with?", function()
    test("string[\":end_with?\"](suffix...) -> true or false", function()
      assert.equal(rubik["end_with?"]("pineapple", "apple"), true)
      assert.equal(rubik["end_with?"]("pineapple", "pine"), false)

      assert.equal(rubik["end_with?"]("pineapple", "pine", "apple", "grape"), true)
    end)
  end)

  -- String#start_with?
  -- -------------------------------------------------------------------

  describe("String#start_with?", function()
    test("string[\":start_with?\"]([prefixes]+) -> true or false", function()
      assert.equal(rubik["start_with?"]("pineapple", "pine"), true)
      assert.equal(rubik["start_with?"]("pineapple", "apple"), false)

      assert.equal(rubik["start_with?"]("pineapple", "apple", "pine", "grape"), true)
    end)
  end)
end)
