return {
	{
		"nvimtools/none-ls.nvim",
		config = function()
			local null = require("null-ls")
			local formatting = null.builtins.formatting
			local diagnostics = null.builtins.diagnostics

			null.setup({
				on_attach = function(client, bufnr)
					if client.supports_method("textDocument/formatting") then
						vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
						vim.api.nvim_create_autocmd("BufWritePre", {
							group = augroup,
							buffer = bufnr,
							callback = function()
								-- on 0.8, you should use vim.lsp.buf.format({ bufnr = bufnr }) instead
								-- on later neovim version, you should use vim.lsp.buf.format({ async = false }) instead
								vim.lsp.buf.format()
							end,
						})
					end
				end,
				sources = {
					formatting.stylua.with({
						filetypes = { "lua" },
					}),
					formatting.prettierd.with({
						filetypes = {
							"markdown",
							"css",
							"scss",
							"html",
							"javascript",
							"javascriptreact",
							"typescript",
							"typescriptreact",
							"json",
						},
					}),
					formatting.beautysh.with({
						filetypes = { "bash" },
					}),
					formatting.clang_format.with({
						filetypes = { "c", "cpp", "tpp", "java" },
					}),
					formatting.rustfmt.with({
						filetypes = { "rust" },
					}),
					formatting.latexindent.with({
						filetypes = { "tex", "bib" },
					}),
					formatting.autopep8.with({
						filetypes = { "python" },
					}),
					formatting.gersemi.with({
						filetypes = { "cmake" },
					}),
					formatting.csharpier.with({
						filetypes = { "cs" },
					}),
					diagnostics.cpplint.with({
						filetypes = { "c", "cpp", "tpp" },
					}),
					diagnostics.eslint_d.with({
						filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
					}),
					diagnostics.cmake_lint.with({
						filetypes = { "cmake" },
					}),
				},
			})
		end,
	},
}
