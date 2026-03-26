return {
	"nvim-neorg/neorg",
	lazy = false, -- Disable lazy loading as some `lazy.nvim` distributions set `lazy = true` by default
	version = "*", -- Pin Neorg to the latest stable release
	dependencies = { { "pysan3/neorg-templates", dependencies = { "L3MON4D3/LuaSnip" } } },
	keys = {
		{
			"<leader>no",
			function()
				local out = vim.fn.expand("%:p:r") .. ".md"
				vim.cmd("Neorg export to-file " .. out)
			end,
			desc = "Export neorg to markdown",
			ft = "norg",
		},
	},
	opts = {
		load = {
			["core.defaults"] = {},
			["external.templates"] = {},
			["core.dirman"] = {
				config = {
					workspaces = {
						notes = "~/notes",
					},
					default_workspace = "notes",
				},
			},
			["core.concealer"] = {},
			["core.export"] = {
				export_dir = "<export-dir>/<language>-export",
			},
			["core.export.markdown"] = {},
			["core.summary"] = {},
		},
	},
}
