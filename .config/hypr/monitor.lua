local monitors = {
	{
		output = "desc:GIGA-BYTE TECHNOLOGY CO. LTD. AORUS FO27Q2 24350B000355",
		mode = "2560x1440@240",
		position = "0x0",
	},
	{ output = "desc:LG Electronics 27GL650F 0x00039D06", mode = "1920x1080@144", position = "2560x0" },
	{ output = "desc:Lenovo Group Limited 0x403D", mode = "1920x1200@60", position = "0x0" },
	{ output = "desc:HP Inc. HP E24 G4 CN43460YQQ", mode = "preferred", position = "1920x0" },
	{ output = "desc:LG Electronics LG ULTRAGEAR 0x0000A689", mode = "preferred", position = "3840x0" },
	{ output = "HDMI-A-2", mode = "1920x1080@60", position = "auto", mirror = "eDP-1" },
}

for _, monitor in ipairs(monitors) do
	monitor.scale = monitor.scale or 1
	hl.monitor(monitor)
end
