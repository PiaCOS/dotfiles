local M = {}

-- Split a string by separator (default is whitespace)
local function split(str, sep)
	sep = sep or "%s"
	local t = {}
	for s in string.gmatch(str, "([^" .. sep .. "]+)") do
		table.insert(t, s)
	end
	return t
end

-- Get parent directory of a path
local function parent_folder(path)
	return string.match(path:gsub("/$", ""), "^(.*)/[^/]+$") or "."
end

-- Run a shell command and return output
local function run_cmd(cmd)
	local handle = io.popen(cmd)
	if not handle then
		return ""
	end
	local result = handle:read("*a")
	handle:close()
	return result
end

-- Get changed and untracked files in a Git repo
local function git_diff(git_dir, repo_dir)
	local base_cmd = "git --git-dir='%s' --work-tree='%s'"

	local diff_cmd = string.format(base_cmd .. " diff --name-only", git_dir, repo_dir)
	local staged_cmd = string.format(base_cmd .. " diff --name-only --cached", git_dir, repo_dir) -- same as staged
	local untracked_cmd = string.format(base_cmd .. " ls-files --others --exclude-standard", git_dir, repo_dir)
	return run_cmd(diff_cmd) .. run_cmd(staged_cmd) .. run_cmd(untracked_cmd)
end

-- Get files from previous commit
local function git_show(git_dir, repo_dir)
	local base_cmd = "git --git-dir='%s'"
	local show_cmd = string.format(base_cmd .. "show --name-only --pretty='format:'", git_dir)
	vim.notify("CMD:", show_cmd)
	return run_cmd(show_cmd)
end

-- Main: find all repos and return list of modified/untracked files
function M.search_repo(opts)
	opts = opts or {}
	local maxdepth = tonumber(opts.maxdepth) or 3
	local diff_mode = tonumber(opts.diff_mode) or 1

	local find_cmd = string.format("find . -maxdepth %d -type d -name '.git'", maxdepth)
	local git_dirs = split(run_cmd(find_cmd), "\n")
	local files = {}

	local selected_fn = (diff_mode == 1) and git_diff or git_show

	for _, git_dir in ipairs(git_dirs) do
		local repo_root = parent_folder(git_dir)
		for _, file in ipairs(split(selected_fn(git_dir, repo_root), "\n")) do
			if file ~= "" then
				table.insert(files, repo_root .. "/" .. file)
			end
		end
	end

	return files
end

return M
