local lsp = require("lspconfig")

local lsp_attach = function()
	local opts = { noremap = true, silent = true, buffer = 0 }
	vim.keymap.set("n", "<leader>tt", function()
		require("trouble").open()
	end)
	vim.keymap.set("n", "<leader>tw", function()
		require("trouble").open("workspace_diagnostics")
	end)
	vim.keymap.set("n", "<leader>td", function()
		require("trouble").open("document_diagnostics")
	end)
	vim.keymap.set("n", "<leader>tq", function()
		require("trouble").open("quickfix")
	end)
	vim.keymap.set("n", "<leader>tl", function()
		require("trouble").open("loclist")
	end)
	vim.keymap.set("n", "gR", function()
		require("trouble").open("lsp_references")
	end)
	vim.keymap.set("n", "<leader>df", require("fzf-lua").lsp_definitions, opts)
	vim.keymap.set("n", "<leader>rf", require("fzf-lua").lsp_references, opts)
end

local lsp_capabilities = require("cmp_nvim_lsp").default_capabilities()

lsp.lua_ls.setup({
	on_attach = lsp_attach,
	capabilities = lsp_capabilities,
	filetypes = { "lua" },
	diagnostics = { globals = { "vim" } },
	settings = {
		workspace = {
			checkThirdParty = false,
		},
	},
})

lsp.marksman.setup({
	on_attach = lsp_attach,
	capabilities = lsp_capabilities,
	filetypes = { "markdown" },
})

lsp.cssls.setup({
	on_attach = lsp_attach,
	capabilities = lsp_capabilities,
	filetypes = { "css", "scss" },
})

lsp.html.setup({
	on_attach = lsp_attach,
	capabilities = lsp_capabilities,
	filetypes = { "html" },
})

lsp.tsserver.setup({
	on_attach = lsp_attach,
	capabilities = lsp_capabilities,
	filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
})

lsp.jsonls.setup({
	on_attach = lsp_attach,
	capabilities = lsp_capabilities,
	filetypes = { "json" },
})

lsp.bashls.setup({
	on_attach = lsp_attach,
	capabilities = lsp_capabilities,
	filetypes = { "sh", "zsh" },
})

lsp.clangd.setup({
	on_attach = lsp_attach,
	capabilities = lsp_capabilities,
	filetypes = { "c", "cpp" },
	root_dir = lsp.util.root_pattern("compile_commands.json", ".git", "CMakeLists.txt"),
})

lsp.cmake.setup({
	on_attach = lsp_attach,
	capabilities = lsp_capabilities,
	filetypes = { "cmake" },
})

lsp.rust_analyzer.setup({
	on_attach = lsp_attach,
	capabilities = lsp_capabilities,
	filetypes = { "rust" },
	root_dir = function(fname)
		return require("lspconfig").util.root_pattern("Cargo.toml")(fname)
			or require("lspconfig").util.path.dirname(fname)
	end,
	settings = {
		["rust-analyzer"] = {
			cargo = { allFeatures = true, loadOutDirsFromCheck = true },
		},
	},
})

lsp.ghdl_ls.setup({
	on_attach = lsp_attach,
	capabilities = lsp_capabilities,
	filetypes = { "vhdl" },
})

lsp.texlab.setup({
	on_attach = lsp_attach,
	capabilities = lsp_capabilities,
	filetypes = { "tex", "bib" },
})

lsp.pyright.setup({
	on_attach = lsp_attach,
	capabilities = lsp_capabilities,
	filetypes = { "python" },
})

local stylua = require("efmls-configs.formatters.stylua")
local prettier = require("efmls-configs.formatters.prettier")
local beautysh = require("efmls-configs.formatters.beautysh")
local clang_format = require("efmls-configs.formatters.clang_format")
local rustfmt = require("efmls-configs.formatters.rustfmt")
local latexindent = require("efmls-configs.formatters.latexindent")
local autopep8 = require("efmls-configs.formatters.autopep8")
local cmake = require("efmls-configs.formatters.gersemi")
local cmake_lint = require("efmls-configs.linters.cmake_lint")

local gcc = require("efmls-configs.linters.gcc")
local eslint_d = require("efmls-configs.linters.eslint_d")

local languages = {
	lua = { stylua },
	markdown = { prettier },
	css = { prettier },
	scss = { prettier },
	html = { prettier },
	javascript = { prettier, eslint_d },
	javascriptreact = { prettier, eslint_d },
	typescript = { prettier, eslint_d },
	typescriptreact = { prettier, eslint_d },
	json = { prettier },
	sh = { beautysh },
	c = { clang_format, gcc },
	cpp = { clang_format, gcc },
	tpp = { clang_format, gcc },
	rust = { rustfmt },
	csharp = { clang_format },
	tex = { latexindent },
	bib = { latexindent },
	python = { autopep8 },
	java = { clang_format },
    cmake = { cmake, cmake_lint },
}

local efmls_config = {
	filetypes = vim.tbl_keys(languages),
	settings = {
		languages = languages,
	},
	init_options = {
		documentFormatting = true,
		documentRangeFormatting = true,
	},
}

lsp.efm.setup(vim.tbl_extend("force", efmls_config, {
	on_attach = lsp_attach,
	capabilities = lsp_capabilities,
}))
