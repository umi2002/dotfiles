local dap = require( "dap" )
dap.adapters.cppdbg = {
    id = "cppdbg",
    type = "executable",
    command = "/home/umi/aur/cpptools/extension/debugAdapters/bin/OpenDebugAD7",
}

dap.configurations.cpp = {
    {
        name = "C++ dap",
        type = "cppdbg",
        cwd = "${workspaceFolder}",
        request = "launch",
        MIMode = "gdb",
        program = function()
            return vim.fn.input(
                       "Path to executable: ", vim.fn.getcwd() .. "/", "file"
                    )
        end,
    },
}

vim.keymap.set(
    "n", "<leader>bp", "<CMD> lua require'dap'.toggle_breakpoint()<CR>"
 )
vim.keymap.set( "n", "<leader>rr", "<CMD> lua require'dap'.continue() <CR>" )
vim.keymap.set( "n", "<leader>rn", "<CMD> lua require'dap'.step_over() <CR>" )
vim.keymap.set( "n", "<leader>ri", "<CMD> lua require'dap'.step_into() <CR>" )
