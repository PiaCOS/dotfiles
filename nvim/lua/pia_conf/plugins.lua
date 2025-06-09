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

	-- Visual Whitespace
	{
    'mcauley-penney/visual-whitespace.nvim',
    config = true,
    event = "ModeChanged *:[vV\22]", -- optionally, lazy load on entering visual mode
    opts = {},
  },

	-- THEMES !!!!!!!!!
		-- Themes
	{
    "zenbones-theme/zenbones.nvim",
    dependencies = "rktjmp/lush.nvim",
    lazy = false,
    priority = 1000,
    config = function()
    	vim.g.zenbones_darken_comments = 45
    	vim.cmd.colorscheme('zenbones')
    end
	},

	{
		'everviolet/nvim', name = 'evergarden',
		priority = 1000, -- Colorscheme plugin is loaded first before any other plugins
		opts = {
			theme = {
				variant = 'fall', -- 'winter'|'fall'|'spring'|'summer'
				accent = 'green',
			},
			editor = {
				transparent_background = false,
				sign = { color = 'none' },
				float = {
					color = 'mantle',
					invert_border = false,
				},
				completion = {
					color = 'surface0',
				},
			},
		}
	},

	{ 'metalelf0/black-metal-theme-neovim', priority = 1000 },
	{ 'aliqyan-21/darkvoid.nvim', priority = 1000 },
	{ 'rebelot/kanagawa.nvim', priority = 1000 },
	{ 'nyoom-engineering/oxocarbon.nvim', priority = 1000 },
	{ 'diegoulloao/neofusion.nvim', priority = 1000 },
})

