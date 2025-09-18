return {
    {
        "coffebar/neovim-project",
        opts = {
            projects = { -- define project roots
                "~/dotfiles/*",
                "~/school/inf3995/INF3995-105/embedded_ws",
                "~/school/inf3995/INF3995-105/station",
                "~/code/*",
            },
            picker = {
                type = "fzf-lua", -- one of "telescope", "fzf-lua", or "snacks"
            },
        },
        init = function()
            -- enable saving the state of plugins in the session
            vim.opt.sessionoptions:append("globals") -- save global variables that start with an uppercase letter and contain at least one lowercase letter.
        end,
        dependencies = {
            { "nvim-lua/plenary.nvim" },
            -- optional picker
            { "ibhagwan/fzf-lua" },
            { "Shatur/neovim-session-manager" },
        },
        lazy = false,
        priority = 100,
        config = function(_, opts)
            require("neovim-project").setup(opts)
            vim.keymap.set("n", "<leader>pf", ":NeovimProjectDiscover<CR>")
        end,
    },
}
