local null_ls = require( "null-ls" )

local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics

local lua_format = {
    name = "lua-format",
    generator = { command = "lua-format", args = { "-" }, to_stdin = true },
}

null_ls.setup(
    {
        sources = {
            diagnostics.clang_check,

            formatting.clang_format.with(
                {
                    filetypes = { "c", "cpp", "objc", "objcpp" },
                    extra_args = {
                        "--style=file:/home/umi/.config/nvim/lua/umi/after/plugin/formatting/.clang-format",
                    },
                }
             ),
            formatting.lua_format.with(
                {
                    filetypes = { "lua" },
                    extra_args = {
                        "--config=/home/umi/.config/nvim/lua/umi/after/plugin/formatting/.lua-format",
                    },
                }
             ),
        },
    }
 )
