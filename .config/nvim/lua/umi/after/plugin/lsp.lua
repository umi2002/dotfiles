require( "mason" ).setup()

local lsp = require( "lsp-zero" ).preset(
                {
        name = "minimal",
        set_lsp_keymaps = true,
        manage_nvim_cmp = false,
        suggest_lsp_servers = false,
    }
             )

vim.keymap.set( "n", "<leader>d", "<CMD>lua vim.diagnostic.open_float()<CR>" )
vim.keymap.set( "n", "<leader>kd", "<CMD>lua vim.diagnostic.goto_prev()<CR>" )
vim.keymap.set( "n", "<leader>jd", "<CMD>lua vim.diagnostic.goto_next()<CR>" )
vim.keymap.set( "n", "<leader>gd", "<CMD>lua vim.buf.definition()<CR>" )
vim.keymap.set( "n", "<leader>gD", "<CMD>lua vim.buf.declaration()<CR>" )
vim.api.nvim_set_keymap(
    "n", "<leader>pf", "<cmd>lua vim.lsp.buf.format()<CR>",
    { noremap = true, silent = true }
 )

-- (Optional) Configure lua language server for neovim
lsp.nvim_workspace()

lsp.setup()
