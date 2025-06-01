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

	-- Telescope
	{
		"nvim-telescope/telescope.nvim",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope-live-grep-args.nvim",
		},
		config = function()
			require("pia_conf.plugins.telescope")
		end,
	},

	--fzf-lua
	{
		"ibhagwan/fzf-lua",
		dependencies = { "nvim-tree/nvim-web-devicons" }, -- optional, icons~
		config = function()
			require("pia_conf.plugins.fzf")
		end,
	},


	-- Treesitter
	{
		'nvim-treesitter/nvim-treesitter',
		build = ':TSUpdate',
		config = function()
			require("pia_conf.plugins.treesitter")
		end,
	},
})

