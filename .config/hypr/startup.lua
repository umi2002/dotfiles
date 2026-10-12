local lib = require("lib")
local rules = require("rules")

local autostart = {
	{ entry = "vesktop.desktop", class = "vesktop" },
	{ entry = "spotify.desktop", class = "spotify" },
	{ entry = "eu.betterbird.Betterbird.desktop", class = "eu.betterbird.Betterbird" },
	{ entry = "bitwarden.desktop", class = "Bitwarden" },
}

local silence_timeout = 60000
local awaiting = {}

local function unsilence(class)
	if not class or not awaiting[class] then
		return
	end
	awaiting[class] = nil
	rules.setSilent(class, false)
end

hl.on("hyprland.start", function()
	lib.sound("desktop-login")

	for _, app in ipairs(autostart) do
		awaiting[app.class] = true
		rules.setSilent(app.class, true)
		lib.launch(app.entry)
	end

	hl.timer(function()
		for class in pairs(awaiting) do
			unsilence(class)
		end
	end, { type = "oneshot", timeout = silence_timeout })
end)

hl.on("window.open", function(window)
	unsilence(window and window.class)
end)
