-- This file can be loaded by calling `lua require('plugins')` from your init.vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
    -- Packer can manage itself
    use {'wbthomason/packer.nvim'}

    use {'nvim-tree/nvim-web-devicons'}

    use('nvim-treesitter/nvim-treesitter', {run = ':TSUpdate'})

    use('nvim-lua/plenary.nvim')

    use('ThePrimeagen/harpoon')

    use('mbbill/undotree')

    use('tpope/vim-fugitive')
    use('tpope/vim-rhubarb')

    use
    {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v1.x',
        requires = {
            -- LSP Support
            {'neovim/nvim-lspconfig'},             -- Required
            {'williamboman/mason.nvim'},           -- Optional
            {'williamboman/mason-lspconfig.nvim'}, -- Optional
            {'j-hui/fidget.nvim'},

            -- Autocompletion
            {'hrsh7th/nvim-cmp'},         -- Required
            {'hrsh7th/cmp-nvim-lsp'},     -- Required
            {'hrsh7th/cmp-buffer'},       -- Optional
            {'hrsh7th/cmp-path'},         -- Optional
            {'saadparwaiz1/cmp_luasnip'}, -- Optional
            {'hrsh7th/cmp-nvim-lua'},     -- Optional

            -- Snippets
            {'L3MON4D3/LuaSnip'},             -- Required
            {'rafamadriz/friendly-snippets'}, -- Optional
        }
    }

    use({
        "jose-elias-alvarez/null-ls.nvim",
        config = function()
            require("null-ls").setup()
        end,
        requires = { "nvim-lua/plenary.nvim" },
    })


    use {'folke/neodev.nvim'}

    use {'mfussenegger/nvim-dap'}

    use {'folke/which-key.nvim'}

    use {'nvim-lualine/lualine.nvim'}

    use {"lukas-reineke/indent-blankline.nvim"}

    use
    { -- Adds git releated signs to the gutter, as well as utilities for managing changes
    'lewis6991/gitsigns.nvim',
        opts = {
            -- See `:help gitsigns.txt`
            signs = {
                add = { text = '+' },
                change = { text = '~' },
                delete = { text = '_' },
                topdelete = { text = '‾' },
                changedelete = { text = '~' },
            },
        },
    }

    use
    {
        'numToStr/Comment.nvim',
        config = function()
            require('Comment').setup()
        end
    }

    use {"ahmedkhalf/project.nvim"}

    use
    {
        'nvim-telescope/telescope.nvim', tag = '0.1.1',
        -- or                            , branch = '0.1.x',
        requires = { {'nvim-lua/plenary.nvim'} }
    }

    use
    {"akinsho/toggleterm.nvim", tag = '*', config = function()
        require("toggleterm").setup()
    end
    }

    use
    {
        "windwp/nvim-autopairs",
        config = function() require("nvim-autopairs").setup {} end
    }

    use ("zbirenbaum/copilot.lua")

    use 'navarasu/onedark.nvim'

end)
