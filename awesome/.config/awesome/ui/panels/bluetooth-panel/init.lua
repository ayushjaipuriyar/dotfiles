local awful = require("awful")
local beautiful = require("beautiful")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi
local wibox = require("wibox")
local helpers = require("helpers")
local gears = require("gears")
local icons = require("icons")

--- AWESOME bluetooth panel
--- ~~~~~~~~~~~~~~~~~~~~~

return function(s)
	--- Widgets
	s.bluetooth = require("ui.panels.bluetooth-panel.bluetooth")

	s.bluetooth_panel = awful.popup({
		type = "dock",
		screen = s,
		-- minimum_height = dpi(320),
		maximum_height = dpi(320),
		minimum_width = dpi(300),
		maximum_width = dpi(480),
		bg = beautiful.transparent,
		ontop = true,
		visible = false,
		placement = function(w)
			awful.placement.top(w, {
				margins = {
					top = beautiful.wibar_height + dpi(4),
					-- top = dpi(15),
					left = s.geometry.width - dpi(500),
				},
			})
		end,
		widget = {
			{
				s.bluetooth,
				layout = wibox.layout.fixed.vertical,
			},
			bg = beautiful.widget_bg,
			shape = helpers.ui.prrect(beautiful.border_radius * 2, true, false, false, false),
			widget = wibox.container.background,
		},
	})
	local hide_bluetooth_panel = gears.timer({
		timeout = 4,
		autostart = true,
		callback = function()
			local focused = awful.screen.focused()
			focused.bluetooth_panel.visible = false
		end,
	})

	--- Toggle container visibility
	awesome.connect_signal("mouse::enter", function()
		awful.screen.focused().bluetooth_panel.visible = not s.bluetooth_panel.visible
	end)
	awesome.connect_signal("mouse::leave", function()
		awful.screen.focused().bluetooth_panel.visible = not s.bluetooth_panel.visible
	end)

	awesome.connect_signal("bluetooth_panel::toggle", function(scr)
		if scr == s then
			s.bluetooth_panel.visible = not s.bluetooth_panel.visible
		end
	end)
end
