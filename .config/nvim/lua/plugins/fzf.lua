local pickers = require("utils.pickers")

vim.pack.add({
	"https://github.com/nvim-tree/nvim-web-devicons",
	"https://github.com/ibhagwan/fzf-lua",
})

local fzf = require("fzf-lua")
fzf.setup({
	files = {
		fd_opts = [[--hidden --exclude .git]],
	},
	grep = {
		rg_opts = [[--hidden --glob '!.git/**' -n --column]],
	},
})

vim.keymap.set("n", "<leader>f", fzf.files)
vim.keymap.set("n", "<leader>gf", fzf.git_files)
vim.keymap.set("n", "<leader>wf", fzf.live_grep)
vim.keymap.set("n", "<leader>bf", fzf.buffers)
vim.keymap.set("n", "<leader>of", fzf.oldfiles)
vim.keymap.set("n", "<leader>cf", pickers.conflicts_search)
