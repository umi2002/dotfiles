vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.cursorline = true

vim.opt.fileencoding = "utf-8"

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.smartindent = true

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.config/nvim/undodir"
vim.opt.undofile = true

vim.opt.hlsearch = true
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 10
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 750

vim.g.mapleader = " "

vim.api.nvim_command([[
  autocmd BufRead,BufNewFile *.tpp set filetype=cpp
]])

vim.opt.conceallevel = 2

local filetypes = {
	"lua",
	"md",
	"css",
	"scss",
	"html",
	"js",
	"jsx",
	"ts",
	"tsx",
	"json",
	"sh",
	"zsh",
	"c",
	"h",
	"cpp",
	"hpp",
	"tpp",
	"rs",
	"cs",
	"verilog",
	"systemverilog",
	"tex",
	"bib",
	"py",
	"java",
	"txt",
}

vim.cmd("augroup FormatOnSave")
vim.cmd("autocmd!")

local lsp_group = vim.api.nvim_create_augroup("LspFormattingGroup", {})
for _, filetype in ipairs(filetypes) do
	vim.api.nvim_create_autocmd("BufWritePost", {
		group = lsp_group,
		pattern = "*." .. filetype,
		callback = function()
			local efm = vim.lsp.get_active_clients({ name = "efm" })

			if vim.tbl_isempty(efm) then
				return
			end

			vim.lsp.buf.format({ name = "efm" })
		end,
	})
end

vim.opt.list = true
vim.opt.listchars:append("space:⋅")
vim.opt.listchars:append("eol:↴")

vim.cmd("augroup END")

vim.g.neovide_refresh_rate = 60
vim.g.neovide_profiler = true
