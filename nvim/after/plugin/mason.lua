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
        "verible",
        "autopep8",
        "js-debug-adapter",
        "java-debug-adapter",
        "java-test",
    },

    auto_update = true,
})
