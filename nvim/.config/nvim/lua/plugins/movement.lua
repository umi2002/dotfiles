return {
	{
		"folke/flash.nvim",
        event = "VeryLazy",
		config = true,
	},
	{
		"ggandor/leap.nvim",
		config = function()
			require("leap").add_default_mappings()
			vim.keymap.set("n", "s", "s")
			vim.keymap.set("n", "S", "S")
			vim.keymap.set({ "n", "x", "o" }, "<leader>l", "<Plug>(leap-forward-to)")
			vim.keymap.set({ "n", "x", "o" }, "<leader>L", "<Plug>(leap-backward-to)")
			vim.keymap.set({ "n", "x", "o" }, "gf", "<Plug>(leap-from-window)")
		end,
	},
}
