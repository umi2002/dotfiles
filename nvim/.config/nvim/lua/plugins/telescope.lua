return {
	{
		"nvim-telescope/telescope.nvim",
		opts = {
			defaults = {
				vimgrep_arguments = vimgrep_arguments,
			},
			pickers = {
				find_files = {
					hidden = true,
					file_ignore_patterns = { "^.git/" },
				},
			},
			extensions = {
				fzf = {
					fuzzy = true, -- false will only do exact matching
					override_generic_sorter = true, -- override the generic sorter
					override_file_sorter = true, -- override the file sorter
					case_mode = "smart_case", -- or "ignore_case" or "respect_case"
					-- the default case_mode is "smart_case"
				},
			},
		},
		config = function(_, opts)
			require("telescope").load_extension("fzf")
			require("telescope").load_extension("projects")
			require("telescope").load_extension("ui-select")

			local builtin = require("telescope.builtin")
			local projects = require("telescope").extensions.projects
			local options = { noremap = true, silent = true }

			-- We cache the results of "git rev-parse"
			-- Process creation is expensive in Windows, so this reduces latency

			local telescopeConfig = require("telescope.config")
			local vimgrep_arguments = { unpack(telescopeConfig.values.vimgrep_arguments) }

			-- I want to search in hidden/dot files.
			table.insert(vimgrep_arguments, "--hidden")
			-- I don't want to search in the `.git` directory.
			table.insert(vimgrep_arguments, "--glob")
			table.insert(vimgrep_arguments, "!**/.git/*")
			table.insert(vimgrep_arguments, "!**/node_modules/*")

			require("telescope").setup(opts)
			local function search_conflicts()
				require("telescope.builtin").git_files({
					prompt_title = "< Merge Conflicts >",
					git_command = { "git", "diff", "--name-only", "--diff-filter=U" },
				})
			end

			vim.keymap.set("n", "<leader>f", builtin.find_files, options)
			vim.keymap.set("n", "<leader>pf", projects.projects, options)
			vim.keymap.set("n", "<leader>gf", builtin.git_files, options)
			vim.keymap.set("n", "<leader>wf", builtin.live_grep, options)
			vim.keymap.set("n", "<leader>bf", builtin.buffers, options)
			vim.keymap.set("n", "<leader>cf", search_conflicts, options)
		end,
	},
	{
		"nvim-telescope/telescope-fzf-native.nvim",
		build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
	},
	{ "nvim-telescope/telescope-ui-select.nvim" },
}
