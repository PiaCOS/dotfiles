local tele = require("telescope")
local lga_actions = require("telescope-live-grep-args.actions")
local vertical_layout = {
	width = 0.8,
	height = 0.8,
	mirror = true,
}

-- setup
tele.setup({
	defaults = {
		layout_strategy = "vertical",
		layout_config = vertical_layout,
		winblend = 10,
		previewer = false,
	},
	extensions = {
		live_grep_args = {
			auto_quoting = true,
			mappings = {
				i = {
					["<C-k>"] = lga_actions.quote_prompt(),
					["<C-i>"] = lga_actions.quote_prompt({ postfix = " --iglob " }),
				},
			},
			theme = "vertical",
			layout_config = vertical_layout,
		},
	},
})

tele.load_extension("live_grep_args")


-- keymaps 
vim.keymap.set("n", "<leader>fF", function() 
	require("telescope.builtin").find_files() 
end, { desc = "Find files" })


vim.keymap.set("n", "<leader>fG", function() 
	require("telescope").extensions.live_grep_args.live_grep_args() 
end, { desc = "Grep (live with args)" })

