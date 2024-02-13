return {
	{
		"mbbill/undotree",
		config = function()
			vim.keymap.set("n", "<leader>u", ":UndotreeToggle<CR>", { noremap = true })
		end,
	},
	{
		"akinsho/bufferline.nvim",
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
		config = function()
			local opts = { noremap = true, silent = true }

			vim.keymap.set("n", "<S-Tab>", "<CMD> bprev<CR>", opts)
			vim.keymap.set("n", "<Tab>", "<CMD> bnext<CR>", opts)
			vim.keymap.set("n", "<leader>qa", "<CMD> bufdo bw! <CR>", opts)
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
		config = function()
			local hover = require("hover")
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
		config = function() end,
	},
}
