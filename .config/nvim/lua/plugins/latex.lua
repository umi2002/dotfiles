vim.pack.add({ "https://github.com/lervag/vimtex" })

vim.g.vimtex_view_method = "zathura"
vim.g.vimtex_compiler_latexmk = {
	options = {
		"-pdf",
		"-shell-escape",
		"-verbose",
		"-file-line-error",
		"-synctex=1",
		"-interaction=nonstopmode",
	},
}
