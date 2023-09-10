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
	filetypes = { "javascript" },
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

lsp.csharp_ls.setup({
	on_attach = lsp_attach,
	capabilities = lsp_capabilities,
	filetypes = { "cs" },
})

lsp.ghdl_ls.setup({
	on_attach = lsp_attach,
	capabilities = lsp_capabilities,
	filetypes = { "vhdl" },
})

lsp.veridian.setup({
	on_attach = lsp_attach,
	capabilities = lsp_capabilities,
	filetypes = { "verilog", "systemverilog" },
	root_dir = function(fname)
		return require("lspconfig").util.root_pattern(".git", ".xpr")(fname) or vim.fn.getcwd()
	end,
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
local prettierd = require("efmls-configs.formatters.prettier_d")
local beautysh = require("efmls-configs.formatters.beautysh")
local clang_format = {
	formatCommand = "clang-format -style='file:/home/umi/formatting/.clang-format'",
	formatStdin = true,
}
local rustfmt = require("efmls-configs.formatters.rustfmt")
local verible = { formatCommand = "verible-verilog-format -", formatStdin = true }
local latexindent = require("efmls-configs.formatters.latexindent")
local autopep8 = require("efmls-configs.formatters.autopep8")

local languages = {
	lua = { stylua },
	markdown = { prettierd },
	css = { prettierd },
	scss = { prettierd },
	html = { prettierd },
	javascript = { prettierd },
	json = { prettierd },
	sh = { beautysh },
	c = { clang_format },
	cpp = { clang_format },
	tpp = { clang_format },
	rust = { rustfmt },
	csharp = { clang_format },
	verilog = { verible },
	systemverilog = { verible },
	tex = { latexindent },
	bib = { latexindent },
	python = { autopep8 },
	java = { clang_format },
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
