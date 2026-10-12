local bar_height = 45
local gap = 10

hl.config({
	general = {
		gaps_in = 2.5,
		gaps_out = { top = bar_height + gap, right = gap + 5, bottom = bar_height + gap, left = gap + 5 },
		border_size = 0,
		layout = "scrolling",
	},
})
