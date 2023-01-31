local awful = require("awful")
local beautiful = require("beautiful")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi
local wibox = require("wibox")
local helpers = require("helpers")
local wbutton = require("ui.widgets.button")

--- Stats Widget
--- ~~~~~~~~~~~~
local function create_boxed_widget(widget_to_be_boxed, width, height, bg_color)
	local box_container = wibox.container.background()
	box_container.bg = bg_color
	box_container.forced_height = height
	box_container.forced_width = width
	box_container.shape = helpers.ui.rrect(beautiful.border_radius)

	local boxed_widget = wibox.widget({
		--- Add margins
		{
			--- Add background color
			{
				--- The actual widget goes here
				widget_to_be_boxed,
				top = dpi(9),
				bottom = dpi(9),
				left = dpi(10),
				right = dpi(10),
				widget = wibox.container.margin,
			},
			widget = box_container,
		},
		margins = dpi(10),
		color = "#FF000000",
		widget = wibox.container.margin,
	})

	return boxed_widget
end

local function widget()
	local widget = wibox.widget({
		id = "device_name",
		font = beautiful.font_name .. "Medium 12",
		align = "center",
		valign = "center",
		widget = wibox.widget.textbox,
		-- text = 'device']
	})
	return widget
end

local function devices(num)
	local id = ""
	local name = ""
	-- awful.spawn.easy_async_with_shell(cmdid, function(stdout)
	--     local id = stdout
	--     -- stats:set_text(id)
	-- end)
	local stats = widget()

	local cmd = [[bluetoothctl devices | awk 'NR==]] .. num .. [[']]

	awful.spawn.easy_async_with_shell(cmd, function(stdout)
		local res = tostring(stdout)
		id = string.sub(res, 8, 24)
		name = string.sub(res, 26, -1)
		stats:set_text(name)
	end)
	-- local cmdid = [[bluetoothctl paired-devices | awk 'NR==]] .. num .. [[{print $2}']]
	-- awful.spawn.easy_async_with_shell(cmdid, function(stdout)
	-- local id = stdout
	-- end)
	-- local final_cmd = [[bluetoothctl connect ]] .. id
	local final_cmd = [[notify-send "]] .. id .. [["]]
	local widget_button = wbutton.elevated.state({
		child = stats,
		normal_bg = beautiful.wibar_bg,
		on_release = function()
			awful.spawn.easy_async_with_shell(final_cmd, function(stdout) end)
		end,
	})

	return widget_button
end

local function connected()
	local stats = widget()
	local checkconnected = [[bluetoothctl info | grep "Connected"| awk '{print $2}']]
	awful.spawn.easy_async_with_shell(checkconnected, function(stdout)
		local status = stdout
		if status:match("yes") then
			local cmd = [[bluetoothctl info | grep "Name"| awk '{print $2}']]
			awful.spawn.easy_async_with_shell(cmd, function(stdout)
				stats:set_text(stdout)
			end)
		else
			stats:set_text("Not Connected ")
		end
	end)

	return stats
end
local function paired_devices_text()
	return wibox.widget({
		id = "device_name",
		font = beautiful.font_name .. "Medium 10",
		align = "left",
		valign = "left",
		widget = wibox.widget.textbox,
		text = "Paired Devices",
	})
end
local function connected_device_text()
	return wibox.widget({
		id = "device_name",
		font = beautiful.font_name .. "Medium 10",
		align = "left",
		valign = "left",
		widget = wibox.widget.textbox,
		text = "Connected to",
	})
end

local stats = wibox.widget({
	connected_device_text(),
	create_boxed_widget(connected(), nil, nil, beautiful.one_bg3),
	paired_devices_text(),
	-- dev_boxes(self),
	-- create_boxed_widget(devices(1), nil, nil, beautiful.one_bg3),
	-- create_boxed_widget(devices(2), nil, nil, beautiful.one_bg3),
	layout = wibox.layout.fixed.vertical,
})
-- stats:add(create_boxed_widget(devices(1), dpi(200), dpi(200), beautiful.one_bg3))
for i = 1, 5 do
	stats:add(create_boxed_widget(devices(i), nil, dpi(50), beautiful.one_bg3))
end

return create_boxed_widget(stats, nil, nil, beautiful.wibar_bg)
