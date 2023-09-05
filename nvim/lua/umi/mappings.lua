local set = vim.keymap.set

set("n", "h", "h", {})
set("n", "j", "j", {})
set("n", "k", "k", {})
set("n", "l", "l", {})

set("n", "<leader>e", vim.cmd.Ex)
set("i", "<C-H>", "<C-W>")

set("n", "<leader>wj", "<CMD> Hex <CR>")
set("n", "<leader>wl", "<CMD> Vex! <CR>")
set("n", "<C-k>", "<C-w>k", { silent = true })
set("n", "<C-j>", "<C-w>j", { silent = true })
set("n", "<C-h>", "<C-w>h", { silent = true })
set("n", "<C-l>", "<C-w>l", { silent = true })

set("n", "<leader>rpo", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

set("n", "<S-j>", "<C-d>zz", { noremap = true, silent = true })
set("n", "<S-k>", "<C-u>zz", { noremap = true, silent = true })
set("v", "<S-j>", "<C-d>zz", { noremap = true, silent = true })
set("v", "<S-k>", "<C-u>zz", { noremap = true, silent = true })

set("n", "<leader>ct", "za", { silent = true })
set("n", "<leader>coa", "zR", { silent = true })
set("n", "<leader>cca", "zM", { silent = true })

set("n", "<leader><CR>", "gf", { silent = true })
