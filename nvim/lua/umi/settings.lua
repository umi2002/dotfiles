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
    'lua', 'md', 'css', 'scss', 'html', 'js', 'json', 'sh', 'zsh',
    'c', 'cpp', 'rs', 'cs', 'verilog', 'systemverilog', 'tex', 'bib', 'py'
}

vim.cmd('augroup FormatOnSave')
vim.cmd('autocmd!')

for _, filetype in ipairs(filetypes) do
    vim.cmd(string.format("autocmd BufWritePre *.%s lua vim.lsp.buf.format()", filetype))
end

vim.cmd('augroup END')
