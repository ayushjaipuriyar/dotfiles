local gears = require("gears")
local awful = require("awful")
local beautiful = require("beautiful")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi
local wibox = require("wibox")
local icons = require("icons")

--- mic OSD
--- ~~~~~~~~~~
local actual = wibox.widget({
	-- icon = icons.mutemic,
	resize = true,
	widget = wibox.widget.imagebox,
})

local update = function()
	awful.spawn.easy_async("pactl get-source-mute @DEFAULT_SOURCE@ | awk '{print $2}'", function(stdout)
		if stdout:match("yes") then
			actual.image = icons.mic
		else
			actual.image = icons.mutemic
		end
	end)
end

local icon = wibox.widget({
	actual,
	forced_height = dpi(150),
	top = dpi(12),
	bottom = dpi(12),
	widget = wibox.container.margin,
})

local mic_osd_height = dpi(250)
local mic_osd_width = dpi(250)

screen.connect_signal("request::desktop_decoration", function(s)
	local s = s or {}
	s.show_vol_osd = false

	s.mic_osd_overlay = awful.popup({
		type = "notification",
		screen = s,
		height = mic_osd_height,
		width = mic_osd_width,
		maximum_height = mic_osd_height,
		maximum_width = mic_osd_width,
		bg = beautiful.transparent,
		offset = dpi(5),
		ontop = true,
		visible = false,
		preferred_anchors = "middle",
		preferred_positions = { "left", "right", "top", "bottom" },
		widget = {
			{
				{
					layout = wibox.layout.fixed.vertical,
					{
						layout = wibox.layout.align.horizontal,
						expand = "none",
						nil,
						icon,
						nil,
					},
				},
				left = dpi(24),
				right = dpi(24),
				widget = wibox.container.margin,
			},
			bg = beautiful.xbackground,
			shape = gears.shape.rounded_rect,
			widget = wibox.container.background,
		},
	})
end)

local hide_osd = gears.timer({
	timeout = 2,
	autostart = true,
	callback = function()
		local focused = awful.screen.focused()
		focused.mic_osd_overlay.visible = false
		focused.show_vol_osd = false
	end,
})

awesome.connect_signal("module::mic_osd:rerun", function()
	if hide_osd.started then
		hide_osd:again()
	else
		hide_osd:start()
	end
end)

local placement_placer = function()
	local focused = awful.screen.focused()
	local mic_osd = focused.mic_osd_overlay
	awful.placement.centered(mic_osd)
	-- awful.placement.next_to(mic_osd, {
	-- preferred_positions = "top",
	-- preferred_anchors = "middle",
	-- geometry = focused.top_panel or s,
	-- offset = {
	-- x = 0,
	-- y = dpi(400)
	-- }
	-- })
end

awesome.connect_signal("module::mic_osd:show", function(bool)
	placement_placer()
	awful.screen.focused().mic_osd_overlay.visible = bool
	if bool then
		update()
		awesome.emit_signal("module::mic_osd:rerun")
		awesome.emit_signal("module::brightness_osd:show", false)
		awesome.emit_signal("module::volume_osd:show", false)
	else
		if hide_osd.started then
			hide_osd:stop()
		end
	end
end)
