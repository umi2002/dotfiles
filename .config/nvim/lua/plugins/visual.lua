vim.pack.add({
	{ src = "https://github.com/catppuccin/nvim", name = "catppuccin" },
	"https://github.com/NvChad/nvim-colorizer.lua",
	"https://github.com/gbprod/yanky.nvim",
	{ src = "https://github.com/j-hui/fidget.nvim", version = "legacy" },
	"https://github.com/lukas-reineke/headlines.nvim",
	"https://github.com/lukas-reineke/indent-blankline.nvim",
})

-- catppuccin (load colorscheme first)
require("catppuccin").setup()
vim.cmd.colorscheme("catppuccin")

-- colorizer
require("colorizer").setup()

-- yanky
require("yanky").setup()

-- fidget
require("fidget").setup()

-- headlines
require("headlines").setup()

-- indent-blankline
require("ibl").setup()
