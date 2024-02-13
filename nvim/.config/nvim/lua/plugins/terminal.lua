return {
	{
		"akinsho/toggleterm.nvim",
		opts = {
			open_mapping = "<leader>`",
			direction = "float",
			start_in_insert = true,
			insert_mappings = false,
			terminal_mappings = false,
			autoscroll = true,
			float_opts = { border = "curved" },
		},
		config = function(_, opts)
			require("toggleterm").setup(opts)
			vim.keymap.set("t", "<esc>", "<C-\\><C-n>", { noremap = true, silent = true })
		end,
	},
}
