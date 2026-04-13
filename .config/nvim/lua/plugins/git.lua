vim.pack.add({
	"https://github.com/tpope/vim-fugitive",
	"https://github.com/tpope/vim-rhubarb",
	"https://github.com/lewis6991/gitsigns.nvim",
})

vim.keymap.set("n", "<leader>gs", vim.cmd.Git)

require("gitsigns").setup({
	current_line_blame = true,
})
