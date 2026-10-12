local lib = require("lib")

local workspace_apps = {
	{ workspace = 1, class = "discord" },
	{ workspace = 2, class = "kitty", follow = true },
	{ workspace = 5, class = "steam_app_.*" },
	{ workspace = 7, class = "Bitwarden" },
	{ workspace = 8, class = "eu.betterbird.Betterbird" },
	{ workspace = 9, class = "Spotify" },
	{ workspace = 10, class = "steam" },
}

for _, app in ipairs(workspace_apps) do
	hl.window_rule({
		name = "ws-" .. app.class:gsub("%W", ""),
		match = { class = "^(" .. app.class .. ")$" },
		workspace = app.workspace .. (app.follow and "" or " silent"),
	})
end

hl.window_rule({ name = "render-steamapp", match = { class = "^(steam_app_.*)$" }, render_unfocused = true })

local screens = lib.laptop
		and {
			["eDP-1"] = { 1 },
			["desc:LG Electronics LG ULTRAGEAR 0x0000A689"] = { 2 },
			["desc:HP Inc. HP E24 G4 CN43460YQQ"] = { 3 },
		}
	or {
		["desc:LG Electronics 27GL650F 0x00039D06"] = { 1, 3, 7, 8, 9 },
		["desc:GIGA-BYTE TECHNOLOGY CO. LTD. AORUS FO27Q2 24350B000355"] = { 2, 5 },
	}

for monitor, workspaces in pairs(screens) do
	for _, workspace in ipairs(workspaces) do
		hl.workspace_rule({ workspace = tostring(workspace), monitor = monitor })
	end
end

if lib.desktop then
	local dimmed = { "kitty", "eu.betterbird.Betterbird", "Bitwarden", "discord", "Spotify" }
	for _, class in ipairs(dimmed) do
		hl.window_rule({ name = "opacity-" .. class:gsub("%W", ""), match = { class = class }, opacity = 0.8 })
	end
end
