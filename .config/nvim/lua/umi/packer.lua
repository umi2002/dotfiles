-- This file can be loaded by calling `lua require('plugins')` from your init.vim
-- Only required if you have packer configured as `opt`
vim.cmd( [[packadd packer.nvim]] )

return require( "packer" ).startup(
           function( use )
        -- Packer can manage itself
        use( { "wbthomason/packer.nvim" } )
        use( { "nvim-tree/nvim-web-devicons" } )
        use( { "nvim-treesitter/nvim-treesitter" }, { run = ":TSUpdate" } )
        use( { "nvim-lua/plenary.nvim" } )
        use( { "ThePrimeagen/harpoon" } )
        use( { "mbbill/undotree" } )
        use( { "tpope/vim-fugitive" } )
        use( { "tpope/vim-rhubarb" } )
        use(
            {
                -- LSP Support
                { "neovim/nvim-lspconfig" }, -- Required
                { "williamboman/mason.nvim" }, -- Optional
                { "williamboman/mason-lspconfig.nvim" }, -- Optional
                { "j-hui/fidget.nvim" },

                -- Autocompletion
                { "hrsh7th/nvim-cmp" }, -- Required
                { "hrsh7th/cmp-nvim-lsp" }, -- Required
                { "hrsh7th/cmp-buffer" }, -- Optional
                { "hrsh7th/cmp-path" }, -- Optional
                { "saadparwaiz1/cmp_luasnip" }, -- Optional
                { "hrsh7th/cmp-nvim-lua" }, -- Optional

                -- Snippets
                { "L3MON4D3/LuaSnip" }, -- Required
            }
         )
        use( { "glepnir/lspsaga.nvim", branch = "main" } )
        use( { "jose-elias-alvarez/null-ls.nvim" } )
        use( { "folke/neodev.nvim" } )
        use( { "mfussenegger/nvim-dap" } )
        use( { "theHamsta/nvim-dap-virtual-text" } )
        use( { "folke/which-key.nvim" } )
        use( { "nvim-lualine/lualine.nvim" } )
        use( { "lukas-reineke/indent-blankline.nvim" } )
        use(
            {
                -- Adds git releated signs to the gutter, as well as utilities for managing changes
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
            }
         )
        use( { "numToStr/Comment.nvim" } )
        use( { "ahmedkhalf/project.nvim" } )
        use( { "nvim-telescope/telescope.nvim" } )
        use(
            {
                "windwp/nvim-autopairs",
                config = function()
                    require( "nvim-autopairs" ).setup( {} )
                end,
            }
         )
        use( { "zbirenbaum/copilot.lua" } )
        use( { "navarasu/onedark.nvim" } )
        use( { "akinsho/toggleterm.nvim" } )
        use( { "akinsho/bufferline.nvim" } )
        use( { "lervag/vimtex" } )
        use( { "nvim-orgmode/orgmode" } )
        use( { "vimwiki/vimwiki" } )
    end
        )
