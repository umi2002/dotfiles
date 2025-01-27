local pickers = require("utils.pickers")

return {
    {
        "ibhagwan/fzf-lua",
        -- optional for icon support
        dependencies = { "nvim-tree/nvim-web-devicons" },
        opts = {},
        config = function(_, opts)
            local fzf = require("fzf-lua")

            vim.keymap.set("n", "<leader>f", fzf.files)
            vim.keymap.set("n", "<leader>pf", pickers.projects_search)
            vim.keymap.set("n", "<leader>gf", fzf.git_files)
            vim.keymap.set("n", "<leader>wf", fzf.live_grep)
            vim.keymap.set("n", "<leader>bf", fzf.buffers)
            vim.keymap.set("n", "<leader>of", fzf.oldfiles)
            vim.keymap.set("n", "<leader>cf", pickers.conflicts_search)
        end,
    },
}
