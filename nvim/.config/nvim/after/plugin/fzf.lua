local fzf = require("fzf-lua")

local opts = { noremap = true, silent = true }

vim.keymap.set("n", "<leader>f", fzf.files, opts)
vim.keymap.set("n", "<leader>gf", fzf.git_files, opts)
vim.keymap.set("n", "<leader>wf", fzf.grep_project, opts)
vim.keymap.set("n", "<leader>bf", fzf.buffers, opts)
vim.keymap.set("n", "<leader>tf", fzf.lsp_workspace_symbols, opts)

fzf.setup(
    {
        keymap = {
            fzf = {
                ["ctrl-q"] = "select-all+accept",
            }
        }
    })
