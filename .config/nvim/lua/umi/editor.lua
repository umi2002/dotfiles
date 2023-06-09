local set = vim.keymap.set

set( "n", "h", "h", {} )
set( "n", "j", "j", {} )
set( "n", "k", "k", {} )
set( "n", "l", "l", {} )

vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.fileencoding = "utf-8"

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.smartindent = true

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv( "HOME" ) .. "/.config/nvim/undodir"
vim.opt.undofile = true

vim.opt.hlsearch = true
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 10
vim.opt.isfname:append( "@-@" )

vim.opt.updatetime = 750

vim.g.mapleader = " "
set( "n", "<leader>e", vim.cmd.Ex )
set( "i", "<C-H>", "<C-W>" )

set( "n", "<leader>wj", vim.cmd.Hex )
set( "n", "<leader>wl", vim.cmd.Vex )
set( "n", "<C-k>", "<C-w>k", { silent = true } )
set( "n", "<C-j>", "<C-w>j", { silent = true } )
set( "n", "<C-h>", "<C-w>h", { silent = true } )
set( "n", "<C-l>", "<C-w>l", { silent = true } )

set( "n", "<leader>rp", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]] )

set( "n", "<S-j>", "<C-d>zz", { noremap = true, silent = true } )
set( "n", "<S-k>", "<C-u>zz", { noremap = true, silent = true } )
set( "v", "<S-j>", "<C-d>zz", { noremap = true, silent = true } )
set( "v", "<S-k>", "<C-u>zz", { noremap = true, silent = true } )

vim.cmd('autocmd BufRead,BufNewFile *.tpp set filetype=cpp')

set( "n", "<leader>bh", ":bp<CR>", { silent = true })
set( "n", "<leader>bl", ":bn<CR>", { silent = true })

local notify = vim.notify
vim.notify = function(msg, ...)
    if msg:match("warning: multiple different client offset_encodings") then
        return
    end

    notify(msg, ...)
end
