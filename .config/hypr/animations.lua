hl.curve("myBezier", { type = "bezier", points = { { 0.05, 0.9 }, { 0.1, 1.05 } } })

hl.config({
	animations = {
		enabled = true,
	},
})

local animations = {
	{ leaf = "windows", speed = 7, bezier = "myBezier" },
	{ leaf = "windowsOut", speed = 7, style = "popin 80%" },
	{ leaf = "border", speed = 10 },
	{ leaf = "borderangle", speed = 8 },
	{ leaf = "fade", speed = 7 },
	{ leaf = "workspaces", speed = 6 },
	{ leaf = "layersIn", speed = 5, style = "slide 80%" },
}

for _, animation in ipairs(animations) do
	animation.enabled = true
	animation.bezier = animation.bezier or "default"
	hl.animation(animation)
end
