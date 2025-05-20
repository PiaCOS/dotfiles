-- lua/user/plugins.lua

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable",
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

-- PLUGINS

require("lazy").setup({
	
	-- Themes
	{
		"nyoom-engineering/oxocarbon.nvim",
		priority = 1000,
	},
	{
		"xero/evangelion.nvim",
		lazy = false,
		priority = 1000,
		opts = {
				overrides = {
				keyword = { fg = "#00ff00", bg = "#222222", undercurl = false },
				["@boolean"] = { link = "Special" },
			},
		},
	},

	-- Telescope
	{
	"nvim-telescope/telescope.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
	config = function()
	require("telescope").setup()
	end
	},

	-- Comment plugin
	{
		"numToStr/Comment.nvim",
		opts = {},
		lazy = false,
	},
})

