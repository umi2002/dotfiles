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

hl.env("HYPRCURSOR_THEME", "catppuccin-mocha-light-cursors")
hl.env("HYPRCURSOR_SIZE", "24")
hl.env("XCURSOR_THEME", "catppuccin-mocha-light-cursors")
hl.env("XCURSOR_SIZE", "24")

local mainMod = "SUPER"
local shiftMod = "SUPER + SHIFT"

hl.bind(shiftMod .. " + Q", hl.dsp.window.close())
hl.bind(shiftMod .. " + X", hl.dsp.exit())
hl.bind(shiftMod .. " + L", hl.dsp.exec_cmd("loginctl lock-session"))
hl.bind(mainMod .. " + Return", hl.dsp.exec_cmd("runapp -- kitty"))
hl.bind(mainMod .. " + N", hl.dsp.exec_cmd("runapp -- brave"))
hl.bind(mainMod .. " + R", hl.dsp.exec_cmd("hyprctl dispatch 'hl.dsp.global(\"umi:runner\")'"), { release = true })
hl.bind(shiftMod .. " + P", hl.dsp.exec_cmd([[grim -g "$(slurp -o)" - | swappy -f -]]))

hl.bind(mainMod .. " + V", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + P", hl.dsp.window.pseudo())
hl.bind(mainMod .. " + S", hl.dsp.layout("togglesplit"))
hl.bind(shiftMod .. " + F", hl.dsp.window.fullscreen())

hl.bind(mainMod .. " + H", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + L", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + K", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + J", hl.dsp.focus({ direction = "down" }))

for i = 1, 10 do
	local key = i % 10
	hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = i }))
	hl.bind(shiftMod .. " + " .. key, hl.dsp.window.move({ workspace = i }))
end

hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }))

hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

hl.bind(shiftMod .. " + M", hl.dsp.layout("swapwithmaster", "auto"))

hl.bind(
	"XF86AudioRaiseVolume",
	hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_SINK@ 2%+ --limit 1"),
	{ locked = true, repeating = true }
)
hl.bind(
	"XF86AudioLowerVolume",
	hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_SINK@ 2%-"),
	{ locked = true, repeating = true }
)
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_SINK@ toggle"), { locked = true })

hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brillo -u 200000 -U 5"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brillo -u 200000 -A 5"), { locked = true, repeating = true })

hl.bind("F9", hl.dsp.pass({ window = "^(discord)$" }))

hl.bind(mainMod .. " + comma", hl.dsp.layout("swapcol", "l"))
hl.bind(mainMod .. " + period", hl.dsp.layout("swapcol", "r"))
