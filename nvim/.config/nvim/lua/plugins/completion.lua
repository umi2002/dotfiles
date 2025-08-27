return {
	{
		"saghen/blink.cmp",
		-- optional: provides snippets for the snippet source
		dependencies = { "L3MON4D3/LuaSnip", "onsails/lspkind.nvim", "nvim-tree/nvim-web-devicons" },

		-- use a release tag to download pre-built binaries
		version = "1.*",
		-- AND/OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
		-- build = 'cargo build --release',
		-- If you use nix, you can build from source using latest nightly rust with:
		-- build = 'nix run .#build-plugin',

		---@module 'blink.cmp'
		---@type blink.cmp.Config
		opts = {
			-- 'default' (recommended) for mappings similar to built-in completions (C-y to accept)
			-- 'super-tab' for mappings similar to vscode (tab to accept)
			-- 'enter' for enter to accept
			-- 'none' for no mappings
			--
			-- All presets have the following mappings:
			-- C-space: Open menu or open docs if already open
			-- C-n/C-p or Up/Down: Select next/previous item
			-- C-e: Hide menu
			-- C-k: Toggle signature help (if signature.enabled = true)
			--
			-- See :h blink-cmp-config-keymap for defining your own keymap
			keymap = {
				preset = "none",
				["<C-k>"] = { "select_prev" },
				["<C-j>"] = { "select_next" },
				["<TAB>"] = { "accept" },
			},

			appearance = {
				-- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
				-- Adjusts spacing to ensure icons are aligned
				nerd_font_variant = "mono",
			},

			-- (Default) Only show the documentation popup when manually triggered
			completion = {
				keyword = { range = "full" },
				documentation = {
					auto_show = true,
					auto_show_delay_ms = 500,
					window = { border = "single" },
				},
				ghost_text = { enabled = true },
				menu = {
					border = "single",
					draw = {
						components = {
							kind_icon = {
								text = function(ctx)
									local icon = ctx.kind_icon
									if vim.tbl_contains({ "Path" }, ctx.source_name) then
										local dev_icon, _ = require("nvim-web-devicons").get_icon(ctx.label)
										if dev_icon then
											icon = dev_icon
										end
									else
										icon = require("lspkind").symbolic(ctx.kind, {
											mode = "symbol",
										})
									end

									return icon .. ctx.icon_gap
								end,

								-- Optionally, use the highlight groups from nvim-web-devicons
								-- You can also add the same function for `kind.highlight` if you want to
								-- keep the highlight groups in sync with the icons.
								highlight = function(ctx)
									local hl = ctx.kind_hl
									if vim.tbl_contains({ "Path" }, ctx.source_name) then
										local dev_icon, dev_hl = require("nvim-web-devicons").get_icon(ctx.label)
										if dev_icon then
											hl = dev_hl
										end
									end
									return hl
								end,
							},
						},
					},
				},
			},

			-- Default list of enabled providers defined so that you can extend it
			-- elsewhere in your config, without redefining it, due to `opts_extend`
			sources = {
				default = { "lsp", "path", "snippets", "buffer" },
			},

			snippets = { preset = "luasnip" },

			-- (Default) Rust fuzzy matcher for typo resistance and significantly better performance
			-- You may use a lua implementation instead by using `implementation = "lua"` or fallback to the lua implementation,
			-- when the Rust fuzzy matcher is not available, by using `implementation = "prefer_rust"`
			--
			-- See the fuzzy documentation for more information
			fuzzy = { implementation = "prefer_rust_with_warning" },

			signature = { enabled = true, window = { border = "single" } },
			cmdline = {
				keymap = { preset = "inherit" },
				completion = { menu = { auto_show = true } },
			},
		},
		opts_extend = { "sources.default" },
	},
	{
		"L3MON4D3/LuaSnip",
		config = function()
			local ls = require("luasnip")
			local s = ls.snippet
			local sn = ls.snippet_node
			local isn = ls.indent_snippet_node
			local t = ls.text_node
			local i = ls.insert_node
			local f = ls.function_node
			local c = ls.choice_node
			local d = ls.dynamic_node
			local r = ls.restore_node
			local events = require("luasnip.util.events")
			local ai = require("luasnip.nodes.absolute_indexer")
			local extras = require("luasnip.extras")
			local l = extras.lambda
			local rep = extras.rep
			local p = extras.partial
			local m = extras.match
			local n = extras.nonempty
			local dl = extras.dynamic_lambda
			local fmt = require("luasnip.extras.fmt").fmt
			local fmta = require("luasnip.extras.fmt").fmta
			local conds = require("luasnip.extras.expand_conditions")
			local postfix = require("luasnip.extras.postfix").postfix
			local types = require("luasnip.util.types")
			local parse = require("luasnip.util.parser").parse_snippet
			local ms = ls.multi_snippet
			local k = require("luasnip.nodes.key_indexer").new_key

			ls.config.set_config({
				store_selection_keys = "<C-s>",
			})

			ls.add_snippets(nil, {
				all = {},
			})
		end,
	},
	-- {
	-- 	"zbirenbaum/copilot.lua",
	-- 	opts = {
	-- 		suggestion = {
	-- 			enabled = false,
	-- 			auto_trigger = true,
	-- 			keymap = {
	-- 				accept = "<C-l>",
	-- 			},
	-- 		},
	-- 	},
	-- },
}
