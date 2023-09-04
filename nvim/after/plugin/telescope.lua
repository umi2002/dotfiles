local fzf = require("fzf-lua")

local opts = { noremap = true, silent = true }

vim.keymap.set("n", "<leader>f", fzf.files, opts)
vim.keymap.set("n", "<leader>gf", fzf.git_files, opts)
vim.keymap.set("n", "<leader>wf", fzf.live_grep, opts)
vim.keymap.set("n", "<leader>bf", fzf.buffers, opts)

fzf.setup(
    {
        keymap = {
            fzf = {
                ["ctrl-q"] = "select-all+accept",
            }
        }
    })
