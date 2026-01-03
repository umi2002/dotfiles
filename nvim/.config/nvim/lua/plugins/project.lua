return {
	{
		"DrKJeff16/project.nvim",
		config = function()
			require("project").setup({
				---@usage set to true to disable setting the current-woriking directory
				--- Manual mode doesn't automatically change your root directory, so you have
				--- the option to manually do so using `:ProjectRoot` command.
				manual_mode = false,
				---@usage Methods of detecting the root directory
				--- Allowed values: **"lsp"** uses the native neovim lsp
				--- **"pattern"** uses vim-rooter like glob pattern matching. Here
				--- order matters: if one is not detected, the other is used as fallback. You
				--- can also delete or rearangne the detection methods.
				-- detection_methods = { "lsp", "pattern" }, -- NOTE: lsp detection will get annoying with multiple langs in one project
				use_lsp = true,
				---@usage patterns used to detect root dir, when **"pattern"** is in detection_methods
				patterns = {
					".git",
					"_darcs",
					".hg",
					".bzr",
					".svn",
					"Makefile",
					"CMakeLists.txt",
					"package.json",
					"angular.json",
				},
				allow_patterns_for_lsp = true,
				allow_different_owners = false,
				enable_autochdir = false,
				show_hidden = true,
				ignore_lsp = {}, ---@type string[]
				exclude_dirs = {}, ---@type string[]
				silent_chdir = true,
				scope_chdir = "global", ---@type 'global'|'tab'|'win'
				datapath = vim.fn.stdpath("data"),
				historysize = 100,
				log = { ---@type Project.Config.Logging
					enabled = false,
					max_size = 1.1,
					logpath = vim.fn.stdpath("state"),
				},
				fzf_lua = { enabled = true }, ---@type Project.Config.FzfLua
			})
			vim.keymap.set("n", "<leader>pf", ":ProjectFzf<CR>")
		end,
	},
}
