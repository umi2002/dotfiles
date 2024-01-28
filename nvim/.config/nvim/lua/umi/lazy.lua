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
	{
		"lukas-reineke/indent-blankline.nvim",
		config = function()
			require("ibl").setup({})
		end,
	},
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
{ 'nvim-telescope/telescope-fzf-native.nvim', build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build' },
	"akinsho/toggleterm.nvim",
	"akinsho/bufferline.nvim",
	"nvim-orgmode/orgmode",
	"lukas-reineke/headlines.nvim",
	"elkowar/yuck.vim",
	"folke/flash.nvim",
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
	"neovim/nvim-lspconfig", -- Required
	{
		"williamboman/mason.nvim", -- Optional
		config = function()
			require("mason").setup()
		end,
	},
	"williamboman/mason-lspconfig.nvim", -- Optional
	"WhoIsSethDaniel/mason-tool-installer.nvim",
	"creativenull/efmls-configs-nvim",
	"hrsh7th/nvim-cmp", -- Required
	"hrsh7th/cmp-nvim-lsp", -- Required
	"hrsh7th/cmp-buffer", -- Optional
	"hrsh7th/cmp-path", -- Optional
	"saadparwaiz1/cmp_luasnip", -- Optional
	"hrsh7th/cmp-nvim-lua", -- Optional
	"hrsh7th/cmp-cmdline", -- Optional
	"hrsh7th/cmp-nvim-lsp-signature-help",
	-- Snippets
	"L3MON4D3/LuaSnip", -- Required
	{

		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = function()
			require("nvim-autopairs").setup()
		end,
	},
	{
		"zbirenbaum/copilot.lua",
		config = function()
			require("copilot").setup({
				suggestion = {
					enabled = true,
					auto_trigger = true,
					keymap = {
						accept = "<C-l>",
					},
				},
			})
		end,
	},
	"folke/trouble.nvim",
	"lewis6991/hover.nvim",
	"christoomey/vim-tmux-navigator",
	{
		"j-hui/fidget.nvim",
		tag = "legacy",
		config = function()
			require("fidget").setup()
		end,
	},
	{
		"folke/todo-comments.nvim",
		opts = {},
	},
	{
		"kosayoda/nvim-lightbulb",
		config = function()
			require("nvim-lightbulb").setup({
				autocmd = { enabled = true },
			})
		end,
	},
	{
		"VidocqH/lsp-lens.nvim",
		config = function()
			require("lsp-lens").setup()
		end,
	},
	{
		"folke/twilight.nvim",
		opts = {
			-- your configuration comes here
			-- or leave it empty to use the default settings
			-- refer to the configuration section below
		},
		config = function()
			require("twilight").setup({})
		end,
	},
	{
		"NvChad/nvim-colorizer.lua",
		config = function()
			require("colorizer").setup()
		end,
	},
})
