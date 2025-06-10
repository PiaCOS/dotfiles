local treesitter = require("nvim-treesitter.configs")

treesitter.setup({
	ensure_installed = {
		"javascript", "typescript", "lua", "json",
		"python", "rust", "fish", "xml",
	},
	highlight = {
		enable = true,
		disable = { "markdown" },
		additional_vim_regex_highlighting = false,
	},
})
