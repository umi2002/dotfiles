local lib = require("lib")

require("startup")
require("input")
require("general")
require("decoration")
require("animations")
require("dwindle")
require("master")
require("gestures")
require("misc")
require("binds")
require("devices")
require("rules")
require("monitor")
require("scrolling")

local mainMod = "SUPER"
local shiftMod = "SUPER + SHIFT"

local volume = "wpctl set-volume @DEFAULT_SINK@"
local brightness = "brillo -u 200000"

local binds = {
	{ key = shiftMod .. " + Q", action = hl.dsp.window.close(), group = "Window", description = "Close window" },
	{
		key = mainMod .. " + V",
		action = hl.dsp.window.float({ action = "toggle" }),
		group = "Window",
		description = "Toggle floating",
	},
	{ key = mainMod .. " + P", action = hl.dsp.window.pseudo(), group = "Window", description = "Toggle pseudo" },
	{
		key = shiftMod .. " + F",
		action = hl.dsp.window.fullscreen(),
		group = "Window",
		description = "Toggle fullscreen",
	},
	{ key = mainMod .. " + S", action = hl.dsp.layout("togglesplit"), group = "Window", description = "Toggle split" },
	{
		key = mainMod .. " + comma",
		action = hl.dsp.layout("swapcol l"),
		group = "Window",
		description = "Swap column left",
	},
	{
		key = mainMod .. " + period",
		action = hl.dsp.layout("swapcol r"),
		group = "Window",
		description = "Swap column right",
	},

	{
		key = mainMod .. " + H",
		action = hl.dsp.layout("focus l"),
		group = "Focus",
		description = "Focus left",
	},
	{
		key = mainMod .. " + L",
		action = hl.dsp.layout("focus r"),
		group = "Focus",
		description = "Focus right",
	},
	{ key = mainMod .. " + K", action = hl.dsp.layout("focus u"), group = "Focus", description = "Focus up" },
	{
		key = mainMod .. " + J",
		action = hl.dsp.layout("focus d"),
		group = "Focus",
		description = "Focus down",
	},
	{
		key = mainMod .. " + mouse_down",
		action = hl.dsp.focus({ workspace = "e+1" }),
		group = "Focus",
		description = "Next workspace",
	},
	{
		key = mainMod .. " + mouse_up",
		action = hl.dsp.focus({ workspace = "e-1" }),
		group = "Focus",
		description = "Previous workspace",
	},

	{ key = mainMod .. " + Return", action = lib.app("foot.desktop"), group = "Launch", description = "Terminal" },
	{ key = mainMod .. " + N", action = lib.app("brave-origin.desktop"), group = "Launch", description = "Browser" },
	{
		key = mainMod .. " + SUPER_L",
		action = hl.dsp.global("umi:runner"),
		opts = { release = true },
		group = "Launch",
		description = "Runner",
	},
	{
		key = shiftMod .. " + P",
		action = hl.dsp.exec_cmd([[grim -g "$(slurp -o)" - | swappy -f -]]),
		group = "Launch",
		description = "Screenshot region",
	},

	{ key = shiftMod .. " + X", action = hl.dsp.exec_cmd("uwsm stop"), group = "Session", description = "Log out" },
	{
		key = shiftMod .. " + L",
		action = hl.dsp.exec_cmd("loginctl lock-session"),
		group = "Session",
		description = "Lock screen",
	},

	{
		key = "XF86AudioRaiseVolume",
		action = hl.dsp.exec_cmd(volume .. " 2%+ --limit 1"),
		opts = { locked = true, repeating = true },
		group = "Media",
		description = "Volume up",
	},
	{
		key = "XF86AudioLowerVolume",
		action = hl.dsp.exec_cmd(volume .. " 2%-"),
		opts = { locked = true, repeating = true },
		group = "Media",
		description = "Volume down",
	},
	{
		key = "XF86AudioMute",
		action = hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_SINK@ toggle"),
		opts = { locked = true },
		group = "Media",
		description = "Mute",
	},
	{
		key = "XF86MonBrightnessUp",
		action = hl.dsp.exec_cmd(brightness .. " -A 5"),
		opts = { locked = true, repeating = true },
		group = "Media",
		description = "Brightness up",
	},
	{
		key = "XF86MonBrightnessDown",
		action = hl.dsp.exec_cmd(brightness .. " -U 5"),
		opts = { locked = true, repeating = true },
		group = "Media",
		description = "Brightness down",
	},

	{
		key = "F9",
		action = hl.dsp.pass({ window = "^(vesktop)$" }),
		group = "Media",
		description = "Discord toggle mute",
	},

	{
		key = mainMod .. " + mouse:272",
		action = hl.dsp.window.drag(),
		opts = { mouse = true },
		group = "Mouse",
		description = "Drag window",
	},
	{
		key = mainMod .. " + mouse:273",
		action = hl.dsp.window.resize(),
		opts = { mouse = true },
		group = "Mouse",
		description = "Resize window",
	},
}

for workspace = 1, 10 do
	local key = workspace % 10
	binds[#binds + 1] = {
		key = mainMod .. " + " .. key,
		action = hl.dsp.focus({ workspace = workspace }),
		group = "Workspace",
		description = "Focus workspace " .. workspace,
	}
	binds[#binds + 1] = {
		key = shiftMod .. " + " .. key,
		action = hl.dsp.window.move({ workspace = workspace }),
		group = "Workspace",
		description = "Move window to workspace " .. workspace,
	}
end

for _, bind in ipairs(binds) do
	hl.bind(bind.key, bind.action, bind.opts)
end

lib.write_json((os.getenv("HOME") or "") .. "/.local/state/hypr/binds.json", binds)
