return {
	{
		"williamboman/mason.nvim",
		config = true,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		dependencies = {
			"williamboman/mason.nvim",
			"neovim/nvim-lspconfig",
		},
		opts = {
			ensure_installed = {
				"lua_ls",
				"marksman",
				"cssls",
				"html",
				"tsserver",
				"jsonls",
				"bashls",
				"rust_analyzer",
				"texlab",
				"pyright",
				"ruff_lsp",
				"jdtls",
				"clangd",
				"cmake",
				"angularls",
				"eslint",
				"csharp_ls",
				"tailwindcss",
			},
		},
	},
	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		dependencies = {
			"williamboman/mason.nvim",
			"neovim/nvim-lspconfig",
		},
		opts = {
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
			},

			auto_update = true,
		},
	},
}
