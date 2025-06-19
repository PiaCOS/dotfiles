local fzf = require("fzf-lua")

fzf.setup({
	"default",
	winopts = {
		height = 0.85,
		width = 0.80,
		preview = {
			layout = "vertical",
			vertical = "down:60%",
		},
	},
	grep = {
		rg_opts = "--hidden --column --line-number --no-heading --color=always --smart-case -e",
		prompt = '-> ',
	},

})

-- keymaps 
vim.keymap.set("n", "<leader>ff", function() 
	require("fzf-lua").files() 
end, { desc = "fzf: Find files" })


vim.keymap.set("n", "<leader>fg", function() 
	require("fzf-lua").live_grep_glob() 
end, { desc = "fzf: Grep" })


-- shows git diff and newfiles
local diff = require("pia_conf.plugins.fzf_git_diff")

vim.keymap.set("n", "<leader>gg", function()
	local files = diff.search_repo({ maxdepth = 2})
  fzf.fzf_exec(files, {
    prompt = "Modified in Repos> ",
    actions = fzf.defaults.actions.files,
		preview = "batcat --style=numbers --color=always --line-range=:500 {}",
  })
end, { desc = "FZF: Modified files in nested repos" })




-- LEGACY THING BUT IT WAS FUNNY
-- check inside git diff IN CHILD FOLDERS
-- FIRST we find all .git/ dirs
-- THEN we want to run 'git diff --name
-- 		but git needs 
-- 				--git-dir -> the .git folder
-- 				--work-tree -> the root repo (containing .git/)
-- 		$1 is the first arg of sh -c --> it's {} (the .git/path)
-- 		${1%/.git} removes the /.git part (only takes suffix) ==> it's shell parameter expansion (pattern removal) like $(variable%pattern)
-- FINALLY sed prepends the repo path to not have relative paths ==> it's kinda like regex 
-- vim.keymap.set("n", "<leader>gm", function()
--   local cmd = [[
--     find . -type d -name ".git" -exec sh -c '
--       repo_dir="${1%/.git}"
--       git --git-dir="$1" --work-tree="$repo_dir" diff --name-only |
--       sed "s|^|$repo_dir/|"
--     ' _ {} \;
--   ]]
--   fzf.fzf_exec(cmd, {
--     prompt = "Modified in Repos> ",
--     actions = fzf.defaults.actions.files
--   })
-- end, { desc = "FZF: Modified files in nested repos" })



