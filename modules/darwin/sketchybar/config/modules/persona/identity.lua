local icon = require("icons")
local colors = require("colors")

Sbar.add("item", "persona", {
  position = "right",
  padding_right = 0,
  padding_left = 0,
  y_offset = 2,
  icon = {
    string = icon.identity.anonymous,
    font = {
      size = 30,
    },
    color = colors.base05,
  },
  label = {
    drawing = true,
  },
})
