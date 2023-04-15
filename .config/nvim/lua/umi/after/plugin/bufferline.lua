require( "bufferline" ).setup(
    {
        options = {
            themable = true,
            numbers = "ordinal",
            diagnostics = "nvim_lsp",
            separator_style = "slant",
            show_close_icon = false,
        },
    }
 )

local opts = { noremap = true, silent = true }

vim.keymap.set( "n", "<S-Tab>", "<CMD> bprev<CR>", opts )
vim.keymap.set( "n", "<Tab>", "<CMD> bnext<CR>", opts )
vim.keymap.set( "n", "<C-w>", "<CMD> bdelete<CR>", opts )
vim.keymap.set( "n", "<leader>qa", "<CMD> bufdo bw! <CR>", opts )
