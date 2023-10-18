require("mason-lspconfig").setup({
    ensure_installed = {
        "lua_ls",
        "marksman",
        "cssls",
        "html",
        "tsserver",
        "jsonls",
        "bashls",
        "rust_analyzer",
        "csharp_ls",
        "texlab",
        "pyright",
        "jdtls",
    },
})

require("mason-tool-installer").setup({
    ensure_installed = {
        "efm",
        "stylua",
        "prettier",
        "prettierd",
        "beautysh",
        "clang-format",
        "beautysh",
        "latexindent",
        "autopep8",
        "js-debug-adapter",
        "java-debug-adapter",
        "java-test",
        "eslint_d",
    },

    auto_update = true,
})
