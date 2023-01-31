local wibox = require("wibox")
local beautiful = require("beautiful")
local dpi = require("beautiful").xresources.apply_dpi
local playerctl_daemon = require("signal.playerctl")
local wbutton = require("ui.widgets.button")

--- Spotify Widget
--- ~~~~~~~~~~~~~~

return function(s)
	local spotify = wibox.widget({
		id = "status",
		-- text = "Not connected",
		align = "center",
		valign = "center",
		font = beautiful.font_name .. "Medium 12",
		widget = wibox.widget.textbox,
	})

	local spotify_widget = wibox.widget({
		layout = wibox.layout.fixed.horizontal,
		spacing = dpi(5),
		{
			spotify,
			top = dpi(1),
			bottom = dpi(1),
			left = dpi(5),
			right = dpi(5),
			widget = wibox.container.margin,
		},
	})

	playerctl_daemon:connect_signal("metadata", function(_, title, artist, __, ___, ____, player_name)
		if player_name == "ncspot" or player_name == "spotify" then
			if title == "" then
				title = "Nothing Playing"
			end
			if artist == "" then
				artist = "Nothing Playing"
			end
			spotify:set_markup_silently(title .. " - " .. artist)
		end
	end)

	-- local widget = wbutton.elevated.state({
	-- child = spotify_widget,
	-- normal_bg = beautiful.wibar_bg,
	-- on_release = function()
	-- awesome.emit_signal("music_panel::toggle", s)
	-- end,
	-- })
	local widget = wibox.widget({
		layout = wibox.layout.fixed.horizontal,
		spacing = dpi(5),
		{
			spotify_widget,
			top = dpi(1),
			bottom = dpi(1),
			left = dpi(5),
			right = dpi(5),
			widget = wibox.container.margin,
		},
	})
	-- widget:connect_signal("mouse::enter", function()
	-- awesome.emit_signal("bluetooth_panel::toggle", s)
	-- end)
	-- widget:connect_signal("mouse::leave", function()
	-- awesome.emit_signal("bluetooth_panel::toggle", s)
	-- end)

	return widget
end
