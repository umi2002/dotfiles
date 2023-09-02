require("hover").setup({
	init = function()
		require("hover.providers.lsp")
		require("hover.providers.man")
		require("hover.providers.dictionary")
	end,
	preview_opts = {
		border = "rounded",
	},
	preview_window = false,
	title = true,
})

vim.keymap.set("n", "<leader>H", require("hover").hover)
vim.keymap.set("n", "<leader>gH", require("hover").hover_select)
