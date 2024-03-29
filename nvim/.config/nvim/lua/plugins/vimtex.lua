return {
	{
		"lervag/vimtex",
		config = function()
			-- This is necessary for VimTeX to load properly. The "indent" is optional.
			-- Note that most plugin managers will do this automatically.
			vim.api.nvim_command("filetype plugin indent on")

			-- This enables Vim's and Neovim's syntax-related features. Without this, some
			-- VimTeX features will not work (see ":help vimtex-requirements" for more
			-- info).
			vim.api.nvim_command("syntax enable")

			-- Viewer options: One may configure the viewer either by specifying a built-in
			-- viewer method:
			vim.g.vimtex_view_method = "zathura"

			-- VimTeX uses latexmk as the default compiler backend. If you use it, which is
			-- strongly recommended, you probably don't need to configure anything. If you
			-- want another compiler backend, you can change it as follows. The list of
			-- supported backends and further explanation is provided in the documentation,
			-- see ":help vimtex-compiler".
			vim.g.vimtex_compiler_method = "latexrun"

			-- Most VimTeX mappings rely on localleader and this can be changed with the
			-- following line. The default is usually fine and is the symbol "\".
			vim.g.maplocalleader = " "

			vim.keymap.set("n", "<leader>cl", "<CMD> VimtexCompile <CR>")
		end,
	},
}
