local function require_all_in_directory(directory)
	local files = vim.fn.globpath(directory, "*.lua", false, true)
	for _, file in pairs(files) do
		local module_name = file:match("([^/]+)%.lua$")
		if module_name and module_name ~= "init" then
			local require_path = "umi" .. "." .. module_name
			require(require_path)
		end
	end
end

local current_directory = "/home/umi/.config/nvim/lua/umi/"
require_all_in_directory(current_directory)
