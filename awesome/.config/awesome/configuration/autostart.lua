local awful = require("awful")
local filesystem = require("gears.filesystem")
local config_dir = filesystem.get_configuration_dir()
local helpers = require("helpers")

local function autostart_apps()
	--- Compositor
	helpers.run.check_if_running("picom", nil, function()
		awful.spawn("picom --config " .. config_dir .. "configuration/picom.conf", false)
		-- awful.spawn("picom --experimental-backend --config ~/.config/picom/picom.conf", false)
	end)
	--- Music Server
	-- helpers.run.run_once_pgrep("mpd")
	-- helpers.run.run_once_pgrep("mpDris2")
	--- Polkit Agent
	helpers.run.run_once_ps(
		"polkit-gnome-authentication-agent-1",
		"/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1"
	)
	helpers.run.run_once_grep("xsettingsd")
	helpers.run.run_once_grep("libinput-gestures-setup start")
	--
	-- helpers.run.run_once_grep(
	-- 	"rclone --vfs-cache-mode writes mount drive: ~/drive --buffer-size 256M --dir-cache-time 72h --drive-chunk-size 32M --log-level INFO --log-file /home/ayush/.logs/rclone-gdrive.log --vfs-read-chunk-size 128M --vfs-read-chunk-size-limit off --allow-other && rclone --vfs-cache-mode writes mount onedrive: ~/onedrive --buffer-size 256M --dir-cache-time 72h --drive-chunk-size 32M --log-level INFO --log-file /home/ayush/.logs/rclone-onedrive.log --vfs-read-chunk-size 128M --vfs-read-chunk-size-limit off --allow-other"
	-- )

	--- Other stuff
	-- helpers.run.run_once_grep("blueman-applet")
	-- helpers.run.run_once_grep("nm-applet")
	helpers.run.run_once_grep("whatsdesk")
	helpers.run.run_once_grep("geary")
	helpers.run.run_once_grep("solaar --w hide --tray-icon-size 30")
	helpers.run.run_once_grep("xset -b")
	helpers.run.run_once_grep("xrandr --output eDP --set TearFree on")
end

autostart_apps()
