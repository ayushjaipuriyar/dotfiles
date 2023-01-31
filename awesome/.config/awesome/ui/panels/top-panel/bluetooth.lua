local awful = require("awful")
local gears = require("gears")
local naughty = require("naughty")
local beautiful = require("beautiful")
local dpi = beautiful.xresources.apply_dpi
local widgets = require("ui.widgets")

--- Do not Disturb Widget
--- ~~~~~~~~~~~~~~~~~~~~~

_G.bluetooth_state = false

local function button(icon)
	return widgets.button.text.state({
		normal_bg = beautiful.wibar_bg,
		normal_shape = gears.shape.circle,
		on_normal_bg = beautiful.one_bg3,
		text_normal_bg = beautiful.accent,
		text_on_normal_bg = beautiful.accent,
		font = beautiful.icon_font .. "Round ",
		size = 20,
		text = icon,
	})
end

local widget = button("")

local update_widget = function()
	if bluetooth_state then
		widget:turn_on()
	else
		widget:turn_off()
	end
end

local check_bluetooth_status = function()
	awful.spawn.easy_async_with_shell("bluetoothctl show | grep 'Powered:' | awk '{print $2}'", function(stdout)
		local status = stdout
		if status:match("no") then
			bluetooth_state = false
		else
			bluetooth_state = true
		end
		update_widget()
	end)
end

check_bluetooth_status()

local toggle_action = function()
	if bluetooth_state then
		bluetooth_state = false
		awful.spawn.easy_async_with_shell("bluetoothctl power off", function(stdout) end)
	else
		bluetooth_state = true
		awful.spawn.easy_async_with_shell("bluetoothctl power on", function(stdout) end)
	end
	update_widget()
end

widget:buttons(gears.table.join(awful.button({}, 1, nil, function()
	toggle_action()
end)))

awesome.connect_signal("button::bluetooth:check", function()
	check_bluetooth_status()
end)
awesome.connect_signal("button::bluetooth:toggle", function()
	check_bluetooth_status()
	toggle_action()
end)

return widget
