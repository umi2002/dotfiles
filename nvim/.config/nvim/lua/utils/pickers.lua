return {
	projects_search = function()
		-- Get the project paths from project.nvim
		local ok, project = pcall(require, "project")
		if not ok then
			vim.notify("project.nvim not found", vim.log.levels.ERROR)
			return
		end

		local projects = project.get_recent_projects()

		-- Format the projects for display
		local formatted_projects = {}
		for _, path in ipairs(projects) do
			-- Get the project name from the path
			local name = vim.fn.fnamemodify(path, ":t")
			-- Add the formatted entry
			table.insert(formatted_projects, {
				name = name,
				path = path,
				display = string.format(" %s\t[%s]", name, path),
			})
		end

		-- Configure the fzf-lua options
		local opts = {
			prompt = "Projects > ",
			actions = {
				["default"] = function(selected)
					-- Extract the path from the selected entry
					local path = selected[1]:match("%[(.+)%]$")
					if path then
						vim.cmd("e" .. path)
					end
				end,
			},
			-- Format the display
			format = function(entry)
				return entry.display
			end,
		}

		-- Launch fzf-lua with the projects
		local fzf = require("fzf-lua")
		fzf.fzf_exec(function(callback)
			for _, entry in ipairs(formatted_projects) do
				callback(entry.display)
			end
			callback(nil)
		end, opts)
	end,

	conflicts_search = function()
		local conflicts = {}
		local job = vim.fn.jobstart("git diff --name-only --diff-filter=U --relative", {
			on_exit = function(_, error)
				if error ~= 0 then
					print(error)
					return
				end

				if #conflicts == 0 then
					print("No conflicts")
					return
				end

				local opts = {
					prompt = "Conflicts > ",
					actions = {
						["default"] = function(selected)
							local path = selected[1]
							if path then
								vim.cmd("e " .. path)
							end
						end,
					},
					-- Format the display
					format = function(entry)
						return entry.display
					end,
				}

				local fzf = require("fzf-lua")
				fzf.fzf_exec(function(callback)
					for _, entry in ipairs(conflicts) do
						callback(entry)
					end
					callback(nil)
				end, opts)
			end,
			on_stdout = function(_, data)
				for _, v in ipairs(data) do
					if v ~= "" then
						table.insert(conflicts, "󰈙 " .. v)
					end
				end
			end,
		})
	end,
}
