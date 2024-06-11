return {
	{
		"neovim/nvim-lspconfig",
		config = function()
			local lsp = require("lspconfig")
			local lsp_attach = function()
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
				vim.keymap.set("n", "<leader>df", require("telescope.builtin").lsp_definitions)
				vim.keymap.set("n", "<leader>rf", require("telescope.builtin").lsp_references)
				vim.keymap.set("n", "<leader>tf", require("telescope.builtin").lsp_dynamic_workspace_symbols)
				vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action)
				vim.keymap.set("n", "<leader>dk", vim.diagnostic.goto_prev)
				vim.keymap.set("n", "<leader>dj", vim.diagnostic.goto_next)
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

			lsp.eslint.setup({
				on_attach = lsp.util.add_hook_after(lsp_attach, function(client, bufnr)
					vim.api.nvim_create_autocmd("BufWritePre", {
						buffer = bufnr,
						command = "EslintFixAll",
					})
				end),
				capabilities = lsp_capabilities,
				filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
			})

			local angular_path =
				"/home/umi/.local/share/nvim/mason/packages/angular-language-server/node_modules/@angular/language-server/bin/"
			local tsserver_path =
				"/home/umi/.local/share/nvim/mason/packages/typescript-language-server/node_modules/typescript/bin/"
			local cmd =
				{ "ngserver", "--stdio", "--tsProbeLocations", tsserver_path, "--ngProbeLocations", angular_path }
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

			lsp.tailwindcss.setup({
				on_attach = lsp_attach,
				capabilities = lsp_capabilities,
				filetypes = { "html", "css", "scss", "javascript", "typescript", "javascriptreact", "typescriptreact" },
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
				on_attach = lsp.util.add_hook_after(lsp_attach, format_on_save),
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
				on_attach = lsp.util.add_hook_after(lsp_attach, format_on_save),
				capabilities = lsp_capabilities,
				filetypes = { "tex", "bib" },
			})

			lsp.pyright.setup({
				on_attach = lsp_attach,
				capabilities = lsp_capabilities,
				filetypes = { "python" },
			})

			lsp.csharp_ls.setup({
				on_attach = lsp_attach,
				capabilities = lsp_capabilities,
				filetypes = { "cs" },
			})

			local bundles = {
				vim.fn.glob(
					"/home/umi/.local/share/nvim/mason/packages/java-debug-adapter/extension/server/com.microsoft.java.debug.plugin-*"
				),
			}

			lsp.jdtls.setup({
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
				root_dir = lsp.util.root_pattern(
					"pom.xml",
					".git",
					"build.gradle",
					"settings.gradle",
					"gradlew",
					"mvnw"
				),
			})
		end,
	},
	{
		"kosayoda/nvim-lightbulb",
		config = true,
	},
	{
		"VidocqH/lsp-lens.nvim",
		config = true,
	},
	{ "elkowar/yuck.vim" },
	{ "gpanders/nvim-parinfer" },
}
