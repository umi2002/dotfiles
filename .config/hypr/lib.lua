local M = {}

local function read_line(path)
	local file = io.open(path)
	if not file then
		return nil
	end
	local line = file:read("l")
	file:close()
	return line
end

M.host = read_line("/etc/hostname") or ""
M.laptop = M.host:find("laptop", 1, true) ~= nil
M.desktop = not M.laptop

local app_dirs = {
	(os.getenv("HOME") or "") .. "/.local/share/applications/",
	"/usr/share/applications/",
}

function M.desktop_exists(entry)
	for _, dir in ipairs(app_dirs) do
		local file = io.open(dir .. entry)
		if file then
			file:close()
			return true
		end
	end
	return false
end

function M.app(entry)
	return hl.dsp.exec_cmd("uwsm app -- " .. entry)
end

function M.launch(entry)
	if not M.desktop_exists(entry) then
		hl.notify("hyprland: missing desktop entry " .. entry)
		return
	end
	hl.exec_cmd("uwsm app -- " .. entry)
end

local escapes = { ['"'] = '\\"', ["\\"] = "\\\\", ["\n"] = "\\n", ["\t"] = "\\t", ["\r"] = "\\r" }

local function quote(value)
	return '"' .. tostring(value):gsub('["\\\n\t\r]', escapes) .. '"'
end

function M.write_json(path, rows)
	os.execute("mkdir -p " .. path:match("^(.*)/[^/]*$"))
	local file = io.open(path, "w")
	if not file then
		return
	end
	local parts = {}
	for _, row in ipairs(rows) do
		local fields = {}
		for _, key in ipairs({ "key", "description", "group" }) do
			if row[key] then
				fields[#fields + 1] = quote(key) .. ":" .. quote(row[key])
			end
		end
		parts[#parts + 1] = "{" .. table.concat(fields, ",") .. "}"
	end
	file:write("[" .. table.concat(parts, ",") .. "]\n")
	file:close()
end

return M
