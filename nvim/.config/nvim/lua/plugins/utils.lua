return {
	{
		"mbbill/undotree",
		config = function()
			vim.keymap.set("n", "<leader>u", ":UndotreeToggle<CR>", { noremap = true })
		end,
	},
	{
		"akinsho/bufferline.nvim",
		version = "*",
		dependencies = "nvim-tree/nvim-web-devicons",
		opts = {
			options = {
				themable = true,
				numbers = "ordinal",
				diagnostics = "nvim_lsp",
				indicator = {
					icon = " ", -- this should be omitted if indicator style is not 'icon'
					style = "icon",
				},
				diagnostics_indicator = function(count, level, diagnostics_dict, context)
					local icon = level:match("error") and " " or " "
					return " " .. icon .. count
				end,
			},
		},
		config = function(opts)
			require("bufferline").setup(_, opts)
			local options = { noremap = true, silent = true }

			vim.keymap.set("n", "<S-Tab>", "<CMD> bprev<CR>", options)
			vim.keymap.set("n", "<Tab>", "<CMD> bnext<CR>", options)
			vim.keymap.set("n", "<leader>qa", "<CMD> bufdo bw! <CR>", options)
		end,
	},
	{
		"numToStr/Comment.nvim",
		opts = {
			ignore = "^$",
		},
	},
	{
		"lewis6991/hover.nvim",
		opts = {
			init = function()
				require("hover.providers.lsp")
				require("hover.providers.man")
				require("hover.providers.dictionary")
			end,
			preview_opts = {
				border = "rounded",
			},
			preview_window = false,
			title = true,
		},
		config = function(_, opts)
			local hover = require("hover")
			hover.setup(opts)

			vim.keymap.set("n", "<leader>H", hover.hover)
			vim.keymap.set("n", "<leader>gH", hover.hover_select)
		end,
	},
	{
		"echasnovski/mini.surround",
		opts = {
			mappings = {
				add = "<leader>sa",
				delete = "<leader>sd",
				find = "<leader>sf",
				find_left = "<leader>sF",
				highlight = "<leader>sh",
				replace = "<leader>sr",
				update_n_lines = "<leader>sn",
			},
		},
	},
	{
		"echasnovski/mini.move",
		config = true,
	},
	{
		"folke/todo-comments.nvim",
		config = function()
			vim.keymap.set("n", "<leader>td", "<cmd>TodoQuickFix<cr>")
		end,
	},
	{
		"folke/trouble.nvim",
		opts = {}, -- for default options, refer to the configuration section for custom setup.
		cmd = "Trouble",
		keys = {
			{
				"<leader>xx",
				"<cmd>Trouble diagnostics toggle<cr>",
				desc = "Diagnostics (Trouble)",
			},
			{
				"<leader>xX",
				"<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
				desc = "Buffer Diagnostics (Trouble)",
			},
			{
				"<leader>cs",
				"<cmd>Trouble symbols toggle focus=false<cr>",
				desc = "Symbols (Trouble)",
			},
			{
				"<leader>cl",
				"<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
				desc = "LSP Definitions / references / ... (Trouble)",
			},
			{
				"<leader>xL",
				"<cmd>Trouble loclist toggle<cr>",
				desc = "Location List (Trouble)",
			},
			{
				"<leader>xQ",
				"<cmd>Trouble qflist toggle<cr>",
				desc = "Quickfix List (Trouble)",
			},
		},
	},
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = true,
	},
	{
		"iamcco/markdown-preview.nvim",
		cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
		ft = { "markdown" },
		build = function()
			vim.fn["mkdp#util#install"]()
		end,
	},
	{
		"arnaupv/nvim-devcontainer-cli",
		opts = {
			-- By default, if no extra config is added, following nvim_dotfiles are
			-- installed: "https://github.com/LazyVim/starter"
			-- This is an example for configuring other nvim_dotfiles inside the docker container
			nvim_dotfiles_repo = "https://github.com/umi2002/dotfiles.git",
			nvim_dotfiles_install_command = "echo 'ok'",
			-- In case you want to change the way the devenvironment is setup, you can also provide your own setup
			setup_environment_repo = "https://github.com/umi2002/dotfiles.git",
			setup_environment_install_command = "echo 'ok'",
		},
	},
}
