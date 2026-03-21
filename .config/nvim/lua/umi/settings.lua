vim.lsp.set_log_level("off")

vim.g.mapleader = " "
vim.g.maplocalleader = " "

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

vim.opt.updatetime = 500

vim.api.nvim_command([[
  autocmd BufRead,BufNewFile *.tpp set filetype=cpp
]])

vim.opt.conceallevel = 2

vim.opt.list = true
vim.opt.listchars:append("space:⋅")
vim.opt.listchars:append("eol:↴")
vim.opt.listchars:append("tab:| ")

vim.g.neovide_refresh_rate = 60
vim.g.neovide_cursor_vfx_mode = "railgun"
vim.g.neovide_cursor_vfx_particle_density = 25.0
vim.g.neovide_cursor_vfx_particle_curl = 1.0
