return {
    {
        "williamboman/mason.nvim",
        config = true,
    },
    {
        "williamboman/mason-lspconfig.nvim",
        dependencies = {
            "williamboman/mason.nvim",
            "neovim/nvim-lspconfig",
        },
        opts = {
            ensure_installed = {
                "clangd",
                "lua_ls",
                "marksman",
                "cssls",
                "html",
                "ts_ls",
                "jsonls",
                "bashls",
                "rust_analyzer",
                "texlab",
                "pyright",
                "jdtls",
                "cmake",
                "angularls",
                "eslint",
                "csharp_ls",
                "tailwindcss",
                "arduino_language_server",
                "ruby_lsp",
            },
        },
    },
    {
        "WhoIsSethDaniel/mason-tool-installer.nvim",
        dependencies = {
            "williamboman/mason.nvim",
            "neovim/nvim-lspconfig",
        },
        opts = {
            ensure_installed = {
                "stylua",
                "prettierd",
                "shfmt",
                "clang-format",
                "latexindent",
                "autopep8",
                "js-debug-adapter",
                "java-debug-adapter",
                "java-test",
                "cmakelang",
                "gersemi",
                "cpplint",
                "csharpier",
                "codelldb",
                "rubocop",
            },

            auto_update = true,
        },
    },
}
