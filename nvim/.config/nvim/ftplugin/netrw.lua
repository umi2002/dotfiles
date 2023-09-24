vim.keymap.set("n", "<C-l>", ":wincmd l<CR>", { silent = true, buffer = true })
vim.keymap.set("n", "<C-h>", ":wincmd h<CR>", { silent = true, buffer = true })
vim.keymap.set("n", "<C-k>", ":wincmd k<CR>", { silent = true, buffer = true })
vim.keymap.set("n", "<C-j>", ":wincmd j<CR>", { silent = true, buffer = true })

vim.keymap.set("n", "h", "<Plug>NetrwBrowseUpDir", { silent = true, buffer = true })
vim.keymap.set("n", "l", "<Plug>NetrwLocalBrowseCheck", { silent = true, buffer = true })
