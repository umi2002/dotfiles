local null_ls = require("null-ls")

local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics

null_ls.setup({
    sources = {
        formatting.stylua,
        formatting.astyle,
        diagnostics.eslint,
        diagnostics.clang_check,
        diagnostics.pycodestyle,
        formatting.clang_format.with(
        {
            filetypes = { "c", "cpp", "objc", "objcpp" },
            extra_args = { "--style=file:/home/umi/.config/nvim/lua/umi/after/plugin/formatting/.clang-format" },
        }
        )
    },
})
