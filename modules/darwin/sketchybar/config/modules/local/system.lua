local icons = require("icons")
local colors = require("colors")

local popup_toggle = "sketchybar --set $NAME popup.drawing=toggle"

local system_logo = Sbar.add("item", {
  padding_right = 0,
  padding_left = 0,
  click_script = popup_toggle,
  y_offset = 2,
  icon = {
    string = icons.apple,
    font = {
      size = 24,
    },
    color = colors.green,
  },
  label = {
    drawing = true,
  },
  popup = {
    align = "left",
    y_offset = 10,
    height = 35,
  }
})

local system_prefs = Sbar.add("item", {
  position = "popup." .. system_logo.name,
  icon = icons.preferences,
  label = "Preferences",
})

system_prefs:subscribe("mouse.clicked", function(_)
  Sbar.exec("open -a 'System Preferences'")
  system_logo:set({ popup = { drawing = false } })
end)
