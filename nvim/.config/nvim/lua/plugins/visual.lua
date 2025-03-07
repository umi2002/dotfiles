return {
	{
		"EdenEast/nightfox.nvim",
		opts = {
			options = {
				-- Compiled file's destination location
				compile_path = vim.fn.stdpath("cache") .. "/nightfox",
				compile_file_suffix = "_compiled", -- Compiled file suffix
				transparent = false, -- Disable setting background
				terminal_colors = true, -- Set terminal colors (vim.g.terminal_color_*) used in `:terminal`
				dim_inactive = false, -- Non focused panes set to alternative background
				module_default = true, -- Default enable value for modules
				colorblind = {
					enable = false, -- Enable colorblind support
					simulate_only = false, -- Only show simulated colorblind colors and not diff shifted
					severity = {
						protan = 0, -- Severity [0,1] for protan (red)
						deutan = 0, -- Severity [0,1] for deutan (green)
						tritan = 0, -- Severity [0,1] for tritan (blue)
					},
				},
				styles = {
					-- Style to be applied to different syntax groups
					comments = "italic", -- Value is any valid attr-list value `:help attr-list`
					conditionals = "bold",
					constants = "underline",
					functions = "bold, italic",
					keywords = "bold",
					numbers = "NONE",
					operators = "NONE",
					strings = "italic",
					types = "bold, underline",
					variables = "NONE",
				},
				inverse = {
					-- Inverse highlight for different types
					match_paren = false,
					visual = false,
					search = false,
				},
				modules = { -- List of various plugins and additional options
					-- ...
				},
			},
			palettes = {},
			specs = {},
			groups = {},
		},
		config = function(_, opts)
			require("nightfox").setup(opts)

			vim.cmd("colorscheme nightfox")
		end,
	},
	{
		"NvChad/nvim-colorizer.lua",
		config = true,
	},
	{
		"folke/twilight.nvim",
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
