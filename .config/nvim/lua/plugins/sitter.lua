vim.pack.add({
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter", version = "main" },
})

vim.api.nvim_create_autocmd("PackChanged", {
	callback = function(ev)
		if ev.data.spec.name == "nvim-treesitter" and ev.data.kind == "update" then
			vim.cmd("TSUpdate")
		end
	end,
})

require("nvim-treesitter").setup({})

require("nvim-treesitter").install({
	"arduino",
	"bash",
	"make",
	"cpp",
	"c",
	"lua",
	"vim",
	"markdown",
	"markdown_inline",
	"html",
	"css",
	"javascript",
	"json",
	"qmljs",
})

vim.api.nvim_create_autocmd("FileType", {
	callback = function(args)
		local ft = args.match
		-- Disable treesitter highlighting for tex
		if ft == "tex" then
			return
		end

		local lang = vim.treesitter.language.get_lang(ft)
		if lang and vim.treesitter.language.add(lang) then
			vim.treesitter.start()
			vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
		end

		-- Enable additional vim regex highlighting for these filetypes
		if vim.tbl_contains({ "latex", "markdown" }, ft) then
			vim.bo.syntax = "on"
		end
	end,
})
