-- Rubik Test
-- ---------------------------------------------------------------------

local rubik = require("../rubik")

-- ---------------------------------------------------------------------

describe("rubik.each", function()
  it("returns the given table", function()
    local t = { 1, 2, 3 }

    assert.are.equal(rubik.each(t), t)
  end)
end)
