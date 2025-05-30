#!/usr/bin/env lua

local settings = require("settings")
local colors = require("colors")

-- Equivalent to the --default domain
Sbar.default({
  updates = "when_shown",
  icon = {
    font = {
      family = settings.font,
      style = "Bold",
      size = 14.0
    },
    color = colors.base07,
    padding_left = settings.paddings,
    padding_right = settings.paddings,
  },
  label = {
    font = {
      family = settings.font,
      style = "Semibold",
      size = 13.0
    },
    color = colors.base07,
    padding_left = settings.paddings,
    padding_right = settings.paddings,
  },
  background = {
    height = 26,
    corner_radius = 9,
    border_width = 2,
  },
  popup = {
    background = {
      border_width = 2,
      corner_radius = 9,
      border_color = colors.base00,
      color = colors.base02,
      shadow = { drawing = true },
    },
    blur_radius = 20,
  },
  padding_left = 5,
  padding_right = 5
})
