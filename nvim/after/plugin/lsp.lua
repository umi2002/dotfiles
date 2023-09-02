local lsp = require("lspconfig")

local lsp_capabilities = require("cmp_nvim_lsp").default_capabilities()
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
	vim.keymap.set("n", "<leader>df", "<CMD> Telescope lsp_definitions  <CR>", opts)
	vim.keymap.set("n", "<leader>rf", "<CMD> Telescope lsp_references  <CR>", opts)
end

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
	filetypes = { "css", "scss", "less" },
})

lsp.html.setup({
	on_attach = lsp_attach,
	capabilities = lsp_capabilities,
	filetypes = { "html" },
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
