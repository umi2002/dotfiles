hl.env("WAYLAND_DISPLAY", "wayland-1")
hl.on("hyprland.start", function()
	hl.exec_cmd("quickshell -p /etc/greetd/quickshell/greetd.qml; hyprctl dispatch exit")
end)
hl.config({
	misc = {
		disable_hyprland_logo = true,
		disable_splash_rendering = true,
		disable_hyprland_guiutils_check = true,
	},
})

