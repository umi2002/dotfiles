vim.pack.add({
	"https://github.com/williamboman/mason.nvim",
	"https://github.com/williamboman/mason-lspconfig.nvim",
	"https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim",
})

require("mason").setup()

require("mason-lspconfig").setup({
	ensure_installed = {
		"clangd",
		"lua_ls",
		"marksman",
		"html",
		"ts_ls",
		"jsonls",
		"bashls",
		"rust_analyzer",
		"texlab",
		"pyright",
		"jdtls",
		"cmake",
		"angularls",
		"eslint",
		"csharp_ls",
		"tailwindcss",
		"arduino_language_server",
		"ruby_lsp",
		"somesass_ls",
		"qmlls",
	},
})

require("mason-tool-installer").setup({
	ensure_installed = {
		"stylua",
		"prettierd",
		"shfmt",
		"clang-format",
		"latexindent",
		"autopep8",
		"js-debug-adapter",
		"java-debug-adapter",
		"java-test",
		"cmakelang",
		"gersemi",
		"cpplint",
		"csharpier",
		"codelldb",
		"rubocop",
		"stylelint",
		"ruff",
	},
	auto_update = true,
})
