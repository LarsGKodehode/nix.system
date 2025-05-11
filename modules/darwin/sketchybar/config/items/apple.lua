local icons = require("icons")
local colors = require("colors")

local popup_toggle = "sketchybar --set $NAME popup.drawing=toggle"

local apple_logo = Sbar.add("item", {
  padding_right = 15,
  padding_left = -5,
  click_script = popup_toggle,
  icon = {
    string = icons.apple,
    font = {
      size = 16,
    },
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

local apple_prefs = Sbar.add("item", {
  position = "popup." .. apple_logo.name,
  icon = icons.preferences,
  label = "Preferences",
})

apple_prefs:subscribe("mouse.clicked", function(_)
  Sbar.exec("open -a 'System Preferences'")
  apple_logo:set({ popup = { drawing = false } } )
end)
