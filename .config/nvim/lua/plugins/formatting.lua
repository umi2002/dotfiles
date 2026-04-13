vim.pack.add({
	"https://github.com/stevearc/conform.nvim",
})

require("conform").setup({
	formatters_by_ft = {
		lua = { "stylua" },
		markdown = { "prettierd" },
		html = { "prettierd" },
		json = { "prettierd" },
		bash = { "shfmt" },
		cmake = { "gersemi" },
		cs = { "csharpier" },
		ruby = { "rubocop" },
		css = { "stylelint" },
		scss = { "stylelint" },
	},
	format_on_save = {
		timeout_ms = 500,
		-- "fallback" means: use LSP if available, otherwise use the formatter above
		lsp_format = "fallback",
	},
})
