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

  -- String#capitalize
  -- -------------------------------------------------------------------

  describe("String#capitalize", function()
    test("string:capitalize() -> string", function()
      assert.equal(rubik.capitalize("Hello, World!"), "Hello, world!")

      -- Upcases first character, downcases all others
      assert.equal(rubik.capitalize("hello, World!"), "Hello, world!")
    end)
  end)

  -- String#downcase
  -- -------------------------------------------------------------------

  describe("String#downcase", function()
    test("string:downcase() -> string", function()
      assert.equal(rubik.downcase("Hello, World!"), "hello, world!")
      assert.equal(rubik.downcase("hello, world!"), "hello, world!")
    end)
  end)

  -- String#upcase
  -- -------------------------------------------------------------------

  describe("String#upcase", function()
    test("string:upcase() -> string", function()
      assert.equal(rubik.upcase("Hello, World!"), "HELLO, WORLD!")
      assert.equal(rubik.upcase("HELLO, WORLD!"), "HELLO, WORLD!")
    end)
  end)

  -- String#swapcase
  -- -------------------------------------------------------------------

  describe("String#swapcase", function()
    test("string:swapcase() -> string", function()
      assert.equal(rubik.swapcase("Hello, World!"), "hELLO, wORLD!")
      assert.equal(rubik.swapcase("hELLO, wORLD!"), "Hello, World!")
    end)
  end)
end)
