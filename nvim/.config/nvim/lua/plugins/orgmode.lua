return {
	{
		"nvim-orgmode/orgmode",
		opts = {
			org_agenda_files = { "~/notes/*.org", "~/notes/*/*.org" },
			org_default_notes_file = "~/notes/index.org",
			org_hide_leading_stars = true,
			org_hide_emphasis_markers = true,
			calendar_week_start_day = 0,
			org_agenda_start_on_weekday = 0,
			org_todo_keyword_faces = {
				TODO = ":background #569fba :foreground red",
				DONE = ":foreground green",
			},
			mappings = {
				org = {
					org_cycle = "<leader><TAB>",
					org_global_cycle = "<leader><S-TAB>",
					org_open_at_point = "<CR>",
				},
			},
		},
		config = function()
			require("orgmode").setup_ts_grammar()
require("headlines").setup({
	org = {
		headline_highlights = false,
	},
})
		end,
	},
}
