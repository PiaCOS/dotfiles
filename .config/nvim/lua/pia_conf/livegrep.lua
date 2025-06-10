local fzf = require('fzf-lua')

function LiveGrepInDir()
	vim.ui.input({ prompt = "Search in folder: " }, function(input)
		if input == nil or input == '' then
			print("Cancelled, nya~")
			return
		end
		fzf.grep({ cwd = input })
	end)
end

vim.api.nvim_set_keymap(
	'n', '<leader>fs',
	"<cmd>lua LiveGrepInDir()<CR>",
	{ noremap = true, silent = true }
)
