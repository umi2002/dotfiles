vim.pack.add({
	"https://github.com/neovim/nvim-lspconfig",
	"https://github.com/gpanders/nvim-parinfer",
})

local lsp_attach = function(client, bufnr)
	vim.keymap.set("n", "<leader>df", require("fzf-lua").lsp_definitions)
	vim.keymap.set("n", "<leader>rf", require("fzf-lua").lsp_references)
	vim.keymap.set("n", "<leader>tf", require("fzf-lua").lsp_workspace_symbols)
	vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action)
	vim.keymap.set("n", "<leader>dk", function()
		vim.diagnostic.jump({ count = -1, float = true })
	end)
	vim.keymap.set("n", "<leader>dj", function()
		vim.diagnostic.jump({ count = 1, float = true })
	end)

	if client and client:supports_method("textDocument/codeLens") then
		vim.lsp.codelens.enable(true, { bufnr = bufnr })
	end
end

local lsp_capabilities = require("blink.cmp").get_lsp_capabilities()

local default_config = {
	on_attach = lsp_attach,
	capabilities = lsp_capabilities,
}

local angularls_path = vim.fn.expand("$MASON/packages/angular-language-server")
local cmd = {
	"ngserver",
	"--stdio",
	"--tsProbeLocations",
	table.concat({
		vim.uv.cwd(),
		angularls_path,
	}, ","),
	"--ngProbeLocations",
	table.concat({
		vim.uv.cwd(),
		angularls_path .. "/node_modules/@angular/language-server",
	}, ","),
}

-- For jdtls
local bundles = {
	vim.fn.glob(
		"/home/umi/.local/share/nvim/mason/packages/java-debug-adapter/extension/server/com.microsoft.java.debug.plugin-*"
	),
}

local custom_configs = {
	lua_ls = {
		diagnostics = { globals = { "vim" } },
		settings = {
			workspace = {
				checkThirdParty = false,
			},
		},
	},
	eslint = {
		on_attach = function(client, bufnr)
			lsp_attach(client, bufnr)
			vim.api.nvim_create_autocmd("BufWritePre", {
				buffer = bufnr,
				command = "LspEslintFixAll",
			})
		end,
	},
	angularls = {
		cmd = cmd,
		on_new_config = function(new_config, new_root_dir)
			new_config.cmd = cmd
		end,
	},
	clangd = {
		cmd = {
			"clangd",
			"--fallback-style=Google",
		},
	},
	rust_analyzer = {
		root_dir = function(fname)
			return require("lspconfig").util.root_pattern("Cargo.toml")(fname)
				or require("lspconfig").util.path.dirname(fname)
		end,
		settings = {
			["rust-analyzer"] = {
				cargo = { allFeatures = true, loadOutDirsFromCheck = true },
			},
		},
	},
	jdtls = {
		cmd = {
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
			"-jar",
			"/home/umi/.local/share/nvim/mason/packages/jdtls/plugins/org.eclipse.equinox.launcher_1.6.600.v20231106-1826.jar",
			"-configuration",
			"/home/umi/.local/share/nvim/mason/packages/jdtls/config_linux",
			"-data",
			"/home/umi/.local/share/nvim/mason/packages/jdtls/workspace",
		},
		init_options = {
			bundles = bundles,
		},
		root_markers = { "pom.xml", ".git", "build.gradle", "settings.gradle", "gradlew", "mvnw" },
	},
	pyright = {
		settings = {
			pyright = {
				-- Using Ruff's import organizer
				disableOrganizeImports = true,
			},
			python = {
				analysis = {
					-- Ignore all files for analysis to exclusively use Ruff for linting
					ignore = { "*" },
				},
			},
		},
	},
	ruff = {
		on_attach = function(client, bufnr)
			lsp_attach(client, bufnr)
			-- Disable hover in favor of Pyright
			client.server_capabilities.hoverProvider = false
		end,
	},
	qmlls = {
		root_markers = { ".git", ".qmlls.ini" },
		workspace_required = false,
	},
}

local servers = {
	"lua_ls",
	"marksman",
	"html",
	"ts_ls",
	"eslint",
	"angularls",
	"jsonls",
	"tailwindcss",
	"bashls",
	"clangd",
	"cmake",
	"rust_analyzer",
	"ghdl_ls",
	"texlab",
	"pyright",
	"csharp_ls",
	"jdtls",
	"ruby_lsp",
	"somesass_ls",
	"ruff",
	"qmlls",
}

for _, server in ipairs(servers) do
	local final_config = vim.tbl_deep_extend("force", default_config, custom_configs[server] or {})
	vim.lsp.enable(server)
	vim.lsp.config(server, final_config)
end
