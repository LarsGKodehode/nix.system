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
			size = 10,
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
	update_freq = 1,
	y_offset = 0,
})

local function clock_update()
	local day = os.date("%a")       -- Get abbreviated day of the week (Mon, Tue, etc.)
	local date = os.date("%Y-%m-%d") -- Get full date (2025-05-11)
	local time = os.date("%H:%M:%S") -- Get time in hour:minute:second format
	local timezone = os.date("%z")  -- Get timezone offset (+0200 or similar)

	-- Format the time as "Day YYYY-MM-DD HH:MM:SS+TZ"
	local formatted_time = string.format("%s %s %s%s", day, date, time, timezone)
	today.clock:set({ icon = formatted_time })
end

today.clock:subscribe({ "forced", "routine" }, clock_update)
