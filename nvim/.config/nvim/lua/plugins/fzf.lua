return {
	{
		"ibhagwan/fzf-lua",
		-- optional for icon support
		dependencies = { "nvim-tree/nvim-web-devicons" },
		-- or if using mini.icons/mini.nvim
		-- dependencies = { "echasnovski/mini.icons" },
		opts = {},
		config = function(_, opts)
			local fzf = require("fzf-lua")

			vim.keymap.set("n", "<leader>f", fzf.files)
			-- vim.keymap.set("n", "<leader>pf", fzf.projects)
			vim.keymap.set("n", "<leader>gf", fzf.git_files)
			vim.keymap.set("n", "<leader>wf", fzf.live_grep)
			vim.keymap.set("n", "<leader>bf", fzf.buffers)
		end,
	},
}
