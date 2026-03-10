return {
	{
		"catppuccin/nvim",
		name = "catppuccin",
		priority = 1000,
		config = function()
			require("catppuccin").setup()

			vim.cmd.colorscheme("catppuccin")
		end,
	},
	{
		"NvChad/nvim-colorizer.lua",
		config = true,
	},
	{
		"gbprod/yanky.nvim",
		config = true,
	},
	{
		"j-hui/fidget.nvim",
		tag = "legacy",
		config = true,
	},
	{
		"lukas-reineke/headlines.nvim",
		config = true,
	},
	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		config = true,
	},
}
