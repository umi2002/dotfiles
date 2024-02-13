return {
	{
		"williamboman/mason.nvim",
		config = function() end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
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
			},
		},
	},
	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		opts = {
			ensure_installed = {
				"efm",
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
			},

			auto_update = true,
		},
	},
}
