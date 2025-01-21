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
							"json",
							"jsonc",
						},
					}),
					formatting.shfmt.with({
						filetypes = { "bash" },
					}),
					formatting.gersemi.with({
						filetypes = { "cmake" },
					}),
					formatting.csharpier.with({
						filetypes = { "cs" },
					}),
					formatting.rubocop.with({
						filetypes = { "ruby" },
					}),
					diagnostics.cmake_lint.with({
						filetypes = { "cmake" },
					}),
					diagnostics.rubocop.with({
						filetypes = { "ruby" },
					}),
				},
			})
		end,
	},
}
