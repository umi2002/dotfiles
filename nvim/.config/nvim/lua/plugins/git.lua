return {
	{
		"tpope/vim-fugitive",
		config = function()
			vim.keymap.set("n", "<leader>gs", vim.cmd.Git)
		end,
	},
	{"tpope/vim-rhubarb"},
	{
		"lewis6991/gitsigns.nvim",
		opts = {
			current_line_blame = true,
		},
	},
}
