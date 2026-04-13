vim.pack.add({
	"https://github.com/nvim-lua/plenary.nvim",
	"https://github.com/nvimtools/none-ls.nvim",
})

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
					vim.lsp.buf.format({ async = false })
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
				"html",
				"htmlangular",
				"json",
				"jsonc",
				"typescript",
				"javascript",
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
		formatting.stylelint.with({
			filetypes = { "css", "scss" },
		}),
		diagnostics.cmake_lint.with({
			filetypes = { "cmake" },
		}),
		diagnostics.rubocop.with({
			filetypes = { "ruby" },
		}),
		diagnostics.stylelint.with({
			filetypes = { "css", "scss" },
		}),
	},
})
