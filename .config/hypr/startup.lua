local lib = require("lib")

local autostart = {
	"vesktop.desktop",
	"spotify.desktop",
	"eu.betterbird.Betterbird.desktop",
	"bitwarden.desktop",
}

hl.on("hyprland.start", function()
	for _, entry in ipairs(autostart) do
		lib.launch(entry)
	end
end)
