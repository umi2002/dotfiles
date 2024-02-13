return {
	"christoomey/vim-tmux-navigator",
	config = function()
		vim.g.tmux_navigator_no_mappings = 1

		vim.keymap.set("n", "<C-l>", "<CMD> TmuxNavigateRight <CR>")
		vim.keymap.set("n", "<C-h>", "<CMD> TmuxNavigateLeft <CR>")
		vim.keymap.set("n", "<C-j>", "<CMD> TmuxNavigateDown <CR>")
		vim.keymap.set("n", "<C-k>", "<CMD> TmuxNavigateUp <CR>")
	end,
}
