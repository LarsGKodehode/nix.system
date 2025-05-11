#!/usr/bin/env lua

local colors = require "colors"
local settings = require("settings")

local today = {}

today.clock = Sbar.add("item", "clock", {
	icon = {
		align = "right",
		padding_right = 6,
		padding_left = 8,
		font = {
			family = settings.font,
			style = "Bold",
			size = 12.0,
		},
	},
	label = {
		padding_left = 0,
	},
	background = {
		padding_left = 0,
		padding_right = 0,
		color = colors.base03,
		height = 24,
	},
	position = "right",
	update_freq = 10,
	y_offset = 0,
})

local function clock_update()
	local time = os.date("%H:%M")
	today.clock:set({ icon = time })
end

today.clock:subscribe({ "forced", "routine" }, clock_update)
