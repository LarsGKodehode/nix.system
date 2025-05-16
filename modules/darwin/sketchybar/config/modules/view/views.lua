local icons = require("icons")
local colors = require("colors")

local spaces = {}

local function getIcon(i)
  local numSpaces = #icons
      .spaces                                                                        -- Get the number of entries in the spaces table
  local icon = icons.spaces["_" .. i]
  return icon or (i <= numSpaces and icons.spaces["_" .. i] or icons.spaces.default) -- Default to "X" if out of range
end

for i = 1, 10, 1 do
  local space = Sbar.add("space", "space." .. i, {
    associated_space = i,
    icon = {
      string = getIcon(i),
      padding_left = 8,
      padding_right = 8,
      border_color = colors.blue,
      color = colors.base07,
    },
    padding_left = 2,
    padding_right = 2,
    label = {
      padding_right = 20,
      color = colors.purple,
      y_offset = -1,
      drawing = false,
      background = {
        height = 26,
        drawing = true,
        color = colors.base07,
        corner_radius = 8,
      },
    },
  })

  spaces[i] = space.name
end

Sbar.add("bracket", spaces, {
  background = {
    height = 22,
    color = colors.base01,
    border_color = colors.base02,
    shadow = true,
    border_width = 1,
  },
})
