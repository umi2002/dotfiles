local set = vim.keymap.set
local opts = { noremap = true, silent = true }

set("n", "<leader>e", ":Ex<CR>", opts)
set("i", "<C-BS>", "<C-W>", opts)

set("n", "<leader>wj", ":Hex<CR>", opts)
set("n", "<leader>wk", ":Hex!<CR>", opts)
set("n", "<leader>wl", ":Vex!<CR>", opts)
set("n", "<leader>wh", ":Vex<CR>", opts)
set("n", "<C-k>", "<C-w>k", opts)
set("n", "<C-j>", "<C-w>j", opts)
set("n", "<C-h>", "<C-w>h", opts)
set("n", "<C-l>", "<C-w>l", opts)
set("n", "<C-S-H>", ":vertical resize +2<CR>", { silent = true })
set("n", "<C-S-L>", ":vertical resize -2<CR>", { silent = true })
set("n", "<C-S-K>", ":resize +2<CR>", { silent = true })
set("n", "<C-S-J>", ":resize -2<CR>", { silent = true })

set("n", "<S-j>", "<C-d>zz", opts)
set("n", "<S-k>", "<C-u>zz", opts)
set("v", "<S-j>", "<C-d>zz", opts)
set("v", "<S-k>", "<C-u>zz", opts)

set("n", "<leader>ct", "za", opts)
set("n", "<leader>coa", "zR", opts)
set("n", "<leader>cca", "zM", opts)

set("n", "<leader><CR>", "gf", opts)
