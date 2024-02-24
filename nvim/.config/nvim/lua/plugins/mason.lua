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
				"jdtls",
				"cmake",
				"angularls",
				"omnisharp",
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
				"beautysh",
				"clang-format",
				"beautysh",
				"latexindent",
				"autopep8",
				"js-debug-adapter",
				"java-debug-adapter",
				"java-test",
				"eslint_d",
				"cmakelang",
				"gersemi",
				"cpplint",
			},

			auto_update = true,
		},
	},
}
