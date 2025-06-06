local M = {}

	-- Functional util: forEach
local function for_each_do(t, func)
	for _, elem in ipairs(t) do
		func(elem)
	end
end

-- Functional util: Fold
local function fold(acc, t, op)
	for _, elem in ipairs(t) do
		acc = op(acc, elem)
	end
	return acc
end

-- Obligatory helper to split strings
local function split(inputstr, sep)
	sep = sep or "%s"
	local t = {}
	for str in string.gmatch(inputstr, "([^" .. sep .. "]+)") do
		table.insert(t, str)
	end
	return t
end

-- need a slice function..
local function slice(arr, start_i, end_i)
	local sliced = {}
	for i = start_i, end_i do
		table.insert(sliced, arr[i])
	end
	return sliced
end

-- get the parent folder
local function parent_folder(path)
	path = string.gsub(path, "/$", "")
	local parent = string.match(path, "^(.*)/[^/]+$") -- trust me
	return parent or "."
end

-- return a list of files from git diff --name-only + untracked
local function git_diff(git_dir, repo_dir)
	local function run_cmd(cmd)
		local handle = io.popen(cmd)
		local result = handle:read("*a")
		handle:close()
		return result
	end

	local diff_cmd = string.format("git --git-dir='%s' --work-tree='%s' diff --name-only", git_dir, repo_dir)
	local untracked_cmd = string.format("git --git-dir='%s' --work-tree='%s' ls-files --others --exclude-standard", git_dir, repo_dir)

	local modified = run_cmd(diff_cmd)
	local untracked = run_cmd(untracked_cmd)

	return modified .. untracked
end



function M.search_repo()
	-- find all git repo in current folder
	local path = "."
	local cmd = string.format("find %s -type d -name '.git'", path)
	
	local handle = io.popen(cmd)
	local result = handle:read("*a")
	handle:close()
	local repos = split(result,"\n")

	local files = {}
	for _, r in ipairs(repos) do
		local repo_root = parent_folder(r)
		local res = git_diff(r, repo_root)
		for _, file in ipairs(split(res, "\n")) do
			if file ~= "" then
				local full_path = repo_root .. "/" .. file
				table.insert(files, full_path)
			end
		end
	end

	return files
end


return M




