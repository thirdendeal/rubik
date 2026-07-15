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
end)
