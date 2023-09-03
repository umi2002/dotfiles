require("mason-lspconfig").setup({
	ensure_installed = {
		"lua_ls",
		"marksman",
		"cssls",
		"html",
		"tsserver",
		"jsonls",
		"bashls",
		"rust_analyzer",
		"csharp_ls",
		"texlab",
		"pyright",
	},
})

require("mason-tool-installer").setup({
	ensure_installed = {
		"stylua",
		"prettier",
		"beautysh",
		"clang-format",
		"beautysh",
		"latexindent",
		"verible",
		"autopep8",
	},

	auto_update = true,
})
