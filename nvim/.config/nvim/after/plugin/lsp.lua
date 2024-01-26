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
    vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
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

local angular_path =
	"/home/umi/.local/share/nvim/mason/packages/angular-language-server/node_modules/@angular/language-server/bin/"
local tsserver_path =
	"/home/umi/.local/share/nvim/mason/packages/typescript-language-server/node_modules/typescript/bin/"
local cmd = { "ngserver", "--stdio", "--tsProbeLocations", tsserver_path, "--ngProbeLocations", angular_path }
lsp.angularls.setup({
	cmd = cmd,
	on_new_config = function(new_config, new_root_dir)
		new_config.cmd = cmd
	end,
	on_attach = lsp_attach,
	capabilities = lsp_capabilities,
	filetypes = { "typescript", "typescriptreact", "html", "css" },
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

local bundles = {
	vim.fn.glob(
		"/home/umi/.local/share/nvim/mason/packages/java-debug-adapter/extension/server/com.microsoft.java.debug.plugin-*"
	),
}

lsp.jdtls.setup({
	cmd = {
		--
		"java",
		"-Declipse.application=org.eclipse.jdt.ls.core.id1",
		"-Dosgi.bundles.defaultStartLevel=4",
		"-Declipse.product=org.eclipse.jdt.ls.core.product",
		"-Dlog.protocol=true",
		"-Dlog.level=ALL",
		"-Xms1g",
		"--add-modules=ALL-SYSTEM",
		"--add-opens",
		"java.base/java.util=ALL-UNNAMED",
		"--add-opens",
		"java.base/java.lang=ALL-UNNAMED",
		--
		"-jar",
		"/home/umi/.local/share/nvim/mason/packages/jdtls/plugins/org.eclipse.equinox.launcher_1.6.600.v20231106-1826.jar",
		"-configuration",
		"/home/umi/.local/share/nvim/mason/packages/jdtls/config_linux",
		"-data",
		"/home/umi/.local/share/nvim/mason/packages/jdtls/workspace",
	},
	on_attach = lsp_attach,
	capabilities = lsp_capabilities,
	filetypes = { "java" },
	init_options = {
		bundles = bundles,
	},
	root_dir = lsp.util.root_pattern("pom.xml", ".git", "build.gradle", "settings.gradle", "gradlew", "mvnw"),
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
