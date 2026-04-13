vim.pack.add({
	"https://github.com/mbbill/undotree",
	"https://github.com/akinsho/bufferline.nvim",
	"https://github.com/numToStr/Comment.nvim",
	"https://github.com/lewis6991/hover.nvim",
	"https://github.com/echasnovski/mini.surround",
	"https://github.com/echasnovski/mini.move",
	"https://github.com/folke/todo-comments.nvim",
	"https://github.com/folke/trouble.nvim",
	"https://github.com/windwp/nvim-autopairs",
	"https://github.com/iamcco/markdown-preview.nvim",
})

-- undotree
vim.keymap.set("n", "<leader>u", ":UndotreeToggle<CR>", { noremap = true })

require("bufferline").setup({
	options = {
		themable = true,
		numbers = "ordinal",
		diagnostics = "nvim_lsp",
		indicator = {
			icon = " ",
			style = "icon",
		},
		diagnostics_indicator = function(count, level, diagnostics_dict, context)
			local icon = level:match("error") and " " or " "
			return " " .. icon .. count
		end,
	},
})
local buf_opts = { noremap = true, silent = true }
vim.keymap.set("n", "<S-Tab>", "<CMD> bprev<CR>", buf_opts)
vim.keymap.set("n", "<Tab>", "<CMD> bnext<CR>", buf_opts)
vim.keymap.set("n", "<leader>qa", "<CMD> bufdo bw! <CR>", buf_opts)

-- Comment.nvim
require("Comment").setup({
	ignore = "^$",
})

-- hover.nvim
local hover = require("hover")
hover.setup({
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
})
vim.keymap.set("n", "<leader>H", hover.hover)
vim.keymap.set("n", "<leader>gH", hover.hover_select)

-- mini.surround
require("mini.surround").setup({
	mappings = {
		add = "<leader>sa",
		delete = "<leader>sd",
		find = "<leader>sf",
		find_left = "<leader>sF",
		highlight = "<leader>sh",
		replace = "<leader>sr",
		update_n_lines = "<leader>sn",
	},
})

-- mini.move
require("mini.move").setup()

-- todo-comments
require("todo-comments").setup()
vim.keymap.set("n", "<leader>td", "<cmd>TodoQuickFix<cr>")

-- trouble
require("trouble").setup()
vim.keymap.set("n", "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", { desc = "Diagnostics (Trouble)" })
vim.keymap.set(
	"n",
	"<leader>xX",
	"<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
	{ desc = "Buffer Diagnostics (Trouble)" }
)
vim.keymap.set("n", "<leader>cs", "<cmd>Trouble symbols toggle focus=false<cr>", { desc = "Symbols (Trouble)" })
vim.keymap.set(
	"n",
	"<leader>cl",
	"<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
	{ desc = "LSP Definitions / references / ... (Trouble)" }
)
vim.keymap.set("n", "<leader>xL", "<cmd>Trouble loclist toggle<cr>", { desc = "Location List (Trouble)" })
vim.keymap.set("n", "<leader>xQ", "<cmd>Trouble qflist toggle<cr>", { desc = "Quickfix List (Trouble)" })

-- nvim-autopairs
require("nvim-autopairs").setup()
