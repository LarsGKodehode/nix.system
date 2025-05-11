#!/usr/bin/env lua

local colors = require("colors")

local bar_height = 27

-- Equivalent to the --bar domain
Sbar.bar({
	blur_radius = 30,
	border_color = colors.base00,
	border_width = 1,
	color = colors.base01,
	corner_radius = 10,
	height = bar_height,
	margin = 6,
	notch_width = 0,
	padding_left = 18,
	padding_right = 10,
	position = "top",
	shadow = true,
	sticky = true,
	topmost = false,
	y_offset = 4,
})
