require( "mason" ).setup()

require( "mason-lspconfig" ).setup(
    { ensure_installed = { "clangd", "lua_ls" } } )

local lsp = require( "lspconfig" )

local lsp_capabilities = require( "cmp_nvim_lsp" ).default_capabilities()
local lsp_attach = function()
    local opts = { noremap = true, silent = true, buffer = 0 }
    vim.keymap.set(
        "n", "<leader>dd", "<CMD> Lspsaga show_line_diagnostics ++unfocus<CR>",
        opts
     )
    vim.keymap.set(
        "n", "<leader>kd", "<CMD> Lspsaga diagnostic_jump_prev <CR>", opts
     )
    vim.keymap.set(
        "n", "<leader>jd", "<CMD> Lspsaga diagnostic_jump_next <CR>", opts
     )
    vim.keymap
        .set( "n", "<leader>df", "<CMD> Telescope diagnostics <CR>", opts )
    vim.keymap.set( "n", "<leader>of", "<CMD> Lspsaga outline <CR>", opts )
    vim.keymap.set( "n", "<leader>gd", "<CMD> Lspsaga goto_definition <CR>",
                    opts )
    vim.keymap.set( "n", "<leader>gD", "<CMD> Lspsaga lsp_finder <CR>", opts )
    vim.keymap.set( "n", "<leader>H", "<CMD> Lspsaga hover_doc <CR>", opts )
    vim.keymap.set( "n", "<leader>pf", vim.lsp.buf.format, opts )
    vim.keymap.set( "n", "<leader>ca", "<CMD> Lspsaga code_action <CR>", opts )
    vim.keymap.set(
        "n", "<leader>rpo", "<CMD> Lspsaga rename ++project <CR>", opts
     )
    vim.keymap.set( "n", "<leader>rpa", "<CMD> Lspsaga rename <CR>", opts )
end

lsp.clangd.setup(
    {
        cmd = { "clangd", "--background-index", "--header-insertion", "never" },
        on_attach = lsp_attach,
        capabilities = lsp_capabilities,
        settings = { clangd = { semanticHighlighting = true } },
    }
 )

lsp.lua_ls.setup(
    {
        on_attach = lsp_attach,
        capabilities = lsp_capabilities,
        filetypes = { "lua" },
        diagnostics = { globals = { "vim" } },
    }
 )

lsp.marksman.setup(
    {
        on_attach = lsp_attach,
        capabilities = lsp_capabilities,
        filetypes = { "markdown" },
    }
 )

require( "lspsaga" ).setup( { ui = { border = "rounded" } } )
