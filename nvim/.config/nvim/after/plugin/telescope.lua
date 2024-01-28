-- You dont need to set any of these options. These are the default ones. Only
-- the loading is important
require("telescope").setup({
	extensions = {
		fzf = {
			fuzzy = true, -- false will only do exact matching
			override_generic_sorter = true, -- override the generic sorter
			override_file_sorter = true, -- override the file sorter
			case_mode = "smart_case", -- or "ignore_case" or "respect_case"
			-- the default case_mode is "smart_case"
		},
	},
})
-- To get fzf loaded and working with telescope, you need to call
-- load_extension, somewhere after setup function:
require("telescope").load_extension("fzf")
require("telescope").load_extension("projects")

local builtin = require("telescope.builtin")
local projects = require("telescope").extensions.projects
local opts = { noremap = true, silent = true }

vim.keymap.set("n", "<leader>f", "<CMD>Telescope find_files hidden=true prompt_prefix=🔍<CR>", opts)
vim.keymap.set("n", "<leader>pf", projects.projects, opts)
vim.keymap.set("n", "<leader>gf", builtin.git_files, opts)
vim.keymap.set("n", "<leader>wf", builtin.live_grep, opts)
vim.keymap.set("n", "<leader>bf", builtin.buffers, opts)
