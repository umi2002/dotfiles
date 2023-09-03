require("bufferline").setup({
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
})

local opts = { noremap = true, silent = true }

vim.keymap.set("n", "<S-Tab>", "<CMD> bprev<CR>", opts)
vim.keymap.set("n", "<Tab>", "<CMD> bnext<CR>", opts)
vim.keymap.set("n", "<leader>qa", "<CMD> bufdo bw! <CR>", opts)
