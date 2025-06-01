local fzf = require("fzf-lua")

fzf.setup({
	"default",
	winopts = {
		height = 0.85,
		width = 0.80,
		preview = {
			layout = "vertical",
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

