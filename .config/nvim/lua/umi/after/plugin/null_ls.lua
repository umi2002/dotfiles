local null_ls = require("null-ls")

null_ls.setup({
    sources = {
        null_ls.builtins.formatting.stylua,
        null_ls.builtins.diagnostics.eslint,
        null_ls.builtins.completion.spell,
        null_ls.builtins.diagnostics.cppcheck,
        null_ls.builtins.diagnostics.clang_check,
        null_ls.builtins.formatting.astyle,
        null_ls.builtins.diagnostics.pycodestyle
    },
})
