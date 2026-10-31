-- Object Spec
-- -----------------------------------------------------------------------------

local inspect = require("inspect")

local rubik = require("rubik")

-- Object
-- -----------------------------------------------------------------------------

describe("Object", function()
  -- ---------------------------------------------------------------------------
  -- Class
  -- ---------------------------------------------------------------------------

  -- Object::new
  -- ---------------------------------------------------------------------------

  describe("Object::new", function()
    test("Object:new(value) -> new object", function()
      local o1 = rubik.Object:new(nil)
      local o2 = rubik.Object:new("any value")

      assert.equal(o1.class, o2.class)
    end)
  end)

  -- Object::fromLiteral
  -- ---------------------------------------------------------------------------

  describe("Object::fromLiteral", function()
    test("Object:fromLiteral(literal) -> new object", function()
      local o1 = rubik.Object:fromLiteral(nil)
      local o2 = rubik.Object:fromLiteral("any value")

      assert.equal(o1.class, o2.class)
    end)
  end)
end)
