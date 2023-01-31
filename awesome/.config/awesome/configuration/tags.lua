local awful = require("awful")
local bling = require("modules.bling")
--- Tags
--- ~~~~

screen.connect_signal("request::desktop_decoration", function(s)
	--- Each screen has its own tag table.
	awful.tag({ "1", "2", "3", "4", "5", "6", "7" }, s, bling.layout.equalarea)
end)
