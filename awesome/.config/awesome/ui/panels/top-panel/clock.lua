local wibox = require("wibox")
local beautiful = require("beautiful")
local helpers = require("helpers")
local dpi = require("beautiful").xresources.apply_dpi

--- Clock Widget
--- ~~~~~~~~~~~~

return function(s)
	local accent_color = beautiful.white
	local clock = wibox.widget({
		widget = wibox.widget.textclock,
		format = "%a %b %e %l:%M %p",
		align = "center",
		valign = "center",
		font = beautiful.font_name .. "Medium 12",
	})

	clock.markup = helpers.ui.colorize_text(clock.text, accent_color)
	clock:connect_signal("widget::redraw_needed", function()
		clock.markup = helpers.ui.colorize_text(clock.text, accent_color)
	end)

	local widget = wibox.widget({
		layout = wibox.layout.fixed.horizontal,
		spacing = dpi(5),
		{
			clock,
			top = dpi(1),
			bottom = dpi(1),
			left = dpi(5),
			right = dpi(5),
			widget = wibox.container.margin,
		},
	})

	return widget
end
