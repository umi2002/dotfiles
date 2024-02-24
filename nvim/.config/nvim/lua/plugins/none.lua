return {
    {
        "nvimtools/none-ls.nvim",
        config = function()
            local null = require("null-ls")
            local formatting = null.builtins.formatting
            local diagnostics = null.builtins.diagnostics

            null.setup({
                sources = {
                    formatting.stylua.with({
                        filetypes = { "lua" },
                    }),
                    formatting.prettierd.with({
                        filetypes = { "markdown", "css", "scss", "html", "javascript", "javascriptreact", "typescript", "typescriptreact", "json" },
                    }),
                    formatting.beautysh.with({
                        filetypes = { "bash" },
                    }),
                    formatting.clang_format.with({
                        filetypes = { "c", "cpp", "tpp", "java" },
                    }),
                    formatting.rustfmt.with({
                        filetypes = { "rust" },
                    }),
                    formatting.latexindent.with({
                        filetypes = { "tex", "bib" },
                    }),
                    formatting.autopep8.with({
                        filetypes = { "python" },
                    }),
                    formatting.gersemi.with({
                        filetypes = { "cmake" },
                    }),
                    formatting.csharpier.with({
                        filetypes = { "cs" },
                    }),
                    diagnostics.cpplint.with({
                        filetypes = { "c", "cpp", "tpp" },
                    }),
                    diagnostics.eslint_d.with({
                        filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
                    }),
                    diagnostics.cmake_lint.with({
                        filetypes = { "cmake" },
                    }),
                },
            })
        end,
    }
}
