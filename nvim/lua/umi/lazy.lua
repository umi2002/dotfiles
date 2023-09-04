local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable releare
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
    "EdenEast/nightfox.nvim",
    "nvim-tree/nvim-web-devicons",
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
    },
    "nvim-lua/plenary.nvim",
    "ThePrimeagen/harpoon",
    "mbbill/undotree",
    "tpope/vim-fugitive",
    "tpope/vim-rhubarb",
    {
        "folke/neodev.nvim",
        config = function()
            require("neodev").setup({})
        end,
    },
    "mfussenegger/nvim-dap",
    {
        "theHamsta/nvim-dap-virtual-text",
        config = function()
            require("nvim-dap-virtual-text").setup({})
        end,
    },
    "rcarriga/nvim-dap-ui",
    "nvim-lualine/lualine.nvim",
    "lukas-reineke/indent-blankline.nvim",
    {
        "lewis6991/gitsigns.nvim",
        opts = {
            -- See `:help gitsigns.txt`
            signs = {
                add = { text = "+" },
                change = { text = "~" },
                delete = { text = "_" },
                topdelete = { text = "‾" },
                changedelete = { text = "~" },
            },
        },
    },
    "numToStr/Comment.nvim",
    "ahmedkhalf/project.nvim",
    "nvim-telescope/telescope.nvim",
    "akinsho/toggleterm.nvim",
    "akinsho/bufferline.nvim",
    "nvim-orgmode/orgmode",
    "lukas-reineke/headlines.nvim",
    "elkowar/yuck.vim",
    "folke/flash.nvim",
    "mfussenegger/nvim-jdtls",
    "lervag/vimtex",
    "echasnovski/mini.surround",
    {
        "echasnovski/mini.move",
        config = function()
            require("mini.move").setup()
        end,
    },
    {
        "gbprod/yanky.nvim",
        config = function()
            require("yanky").setup()
        end,
    },
    "ggandor/leap.nvim",
    -- LSP Support
    "neovim/nvim-lspconfig",       -- Required
    {
        "williamboman/mason.nvim", -- Optional
        config = function()
            require("mason").setup()
        end,
    },
    "williamboman/mason-lspconfig.nvim", -- Optional
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    "creativenull/efmls-configs-nvim",
    "hrsh7th/nvim-cmp",         -- Required
    "hrsh7th/cmp-nvim-lsp",     -- Required
    "hrsh7th/cmp-buffer",       -- Optional
    "hrsh7th/cmp-path",         -- Optional
    "saadparwaiz1/cmp_luasnip", -- Optional
    "hrsh7th/cmp-nvim-lua",     -- Optional
    "hrsh7th/cmp-cmdline",      -- Optional
    "hrsh7th/cmp-nvim-lsp-signature-help",
    -- Snippets
    "L3MON4D3/LuaSnip", -- Required
    "rest-nvim/rest.nvim",
    {

        "windwp/nvim-autopairs",
        event = "InsertEnter",
        config = function()
            require("nvim-autopairs").setup()
        end,
    },
    {
        "Exafunction/codeium.vim",
        config = function()
            vim.g.codeium_no_map_tab = true
            vim.keymap.set("i", "<C-l>", function()
                return vim.fn["codeium#Accept"]()
            end, { expr = true })
        end,
    },
    "sbdchd/neoformat",
    "folke/trouble.nvim",
    "lewis6991/hover.nvim",
    {
        "rcarriga/nvim-notify",
        config = function()
            require("notify").setup()
            vim.notify = require("notify")
        end,
    },
})
