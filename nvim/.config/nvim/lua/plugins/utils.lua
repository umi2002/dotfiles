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
		opts = {
			position = "bottom", -- position of the list can be: bottom, top, left, right
			height = 10, -- height of the trouble list when position is top or bottom
			width = 50, -- width of the list when position is left or right
			icons = true, -- use devicons for filenames
			mode = "workspace_diagnostics", -- "workspace_diagnostics", "document_diagnostics", "quickfix", "lsp_references", "loclist"
			severity = nil, -- nil (ALL) or vim.diagnostic.severity.ERROR | WARN | INFO | HINT
			fold_open = "", -- icon used for open folds
			fold_closed = "", -- icon used for closed folds
			group = true, -- group results by file
			padding = true, -- add an extra new line on top of the list
			cycle_results = true, -- cycle item list when reaching beginning or end of list
			action_keys = { -- key mappings for actions in the trouble list
				-- map to {} to remove a mapping, for example:
				-- close = {},
				close = "q", -- close the list
				cancel = "<esc>", -- cancel the preview and get back to your last window / buffer / cursor
				refresh = "r", -- manually refresh
				jump = { "<cr>", "<tab>", "<2-leftmouse>" }, -- jump to the diagnostic or open / close folds
				open_split = { "wj" }, -- open buffer in new split
				open_vsplit = { "wl" }, -- open buffer in new vsplit
				open_tab = { "<c-t>" }, -- open buffer in new tab
				jump_close = { "o" }, -- jump to the diagnostic and close the list
				toggle_mode = "m", -- toggle between "workspace" and "document" diagnostics mode
				switch_severity = "s", -- switch "diagnostics" severity filter level to HINT / INFO / WARN / ERROR
				toggle_preview = "P", -- toggle auto_preview
				hover = "H", -- opens a small popup with the full multiline message
				preview = "p", -- preview the diagnostic location
				open_code_href = "c", -- if present, open a URI with more information about the diagnostic error
				close_folds = { "cca" }, -- close all folds
				open_folds = { "coa" }, -- open all folds
				toggle_fold = { "ct" }, -- toggle fold of current file
				previous = "k", -- previous item
				next = "j", -- next item
				help = "?", -- help menu
			},
			multiline = true, -- render multi-line messages
			indent_lines = true, -- add an indent guide below the fold icons
			win_config = { border = "single" }, -- window configuration for floating windows. See |nvim_open_win()|.
			auto_open = false, -- automatically open the list when you have diagnostics
			auto_close = false, -- automatically close the list when you have no diagnostics
			auto_preview = true, -- automatically preview the location of the diagnostic. <esc> to close preview and go back to last window
			auto_fold = false, -- automatically fold a file trouble list at creation
			auto_jump = { "lsp_definitions" }, -- for the given modes, automatically jump if there is only a single result
			include_declaration = { "lsp_references", "lsp_implementations", "lsp_definitions" }, -- for the given modes, include the declaration of the current symbol in the results
			signs = {
				-- icons / text used for a diagnostic
				error = "",
				warning = "",
				hint = "",
				information = "",
				other = "",
			},
			use_diagnostic_signs = false, -- enabling this will use the signs defined in your lsp client
		},
	},
}
