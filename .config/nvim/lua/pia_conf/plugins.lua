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
	-- LSP STUFF
	{
		"neovim/nvim-lspconfig",
	},

	{
		"williamboman/mason-lspconfig.nvim",
		dependencies = { "williamboman/mason.nvim", "neovim/nvim-lspconfig" },
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = {
					"ts_ls",
					-- "pyright",
					"ruff",
					"rust_analyzer",
					"lua_ls",
					"lemminx",
					"eslint",
				},
			})

			require("pia_conf.plugins.lsp").setup()
		end,
	},

	--[[
	-- LSP ZERO, Used for Odoo
	{
		"VonHeikemen/lsp-zero.nvim",
		branch = "v2.x",
		dependencies = {
			"neovim/nvim-lspconfig",
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			"hrsh7th/nvim-cmp",
			"hrsh7th/cmp-nvim-lsp",
			"L3MON4D3/LuaSnip",
		},
		config = function()
			require("pia_conf.plugins.lsp_zero").setup()
		end,
	},
	--]]

	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-buffer",
		},
		config = function()
			local cmp = require("cmp")
			cmp.setup({
				sources = {
					{ name = "nvim_lsp" },
					{ name = "buffer" },
				},
				mapping = cmp.mapping.preset.insert({
					["<C-Space>"] = cmp.mapping.complete(),
					["<CR>"] = cmp.mapping.confirm({ select = true }),
				}),
			})
		end,
	},

	{
  	"williamboman/mason.nvim",
  	config = function()
    	require("mason").setup()
  	end,
	},
	
	--[[
	- Vgit
  {
    'tanvirtin/vgit.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
    },
    config = function()
      local vgit = require('vgit')
      vgit.setup()
      vim.keymap.set('n', '<leader>hu', ':VGit hunk_down<CR>', { desc = 'Next Git hunk' })
      vim.keymap.set('n', '<leader>hd', ':VGit hunk_up<CR>', { desc = 'Previous Git hunk' })
    end,
  },
	--]]
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
		'everviolet/nvim', name = 'evergarden',
		priority = 1000, -- Colorscheme plugin is loaded first before any other plugins
		opts = {
			theme = {
				variant = 'spring', -- 'winter'|'fall'|'spring'|'summer'
				accent = 'green',
			},
			editor = {
				transparent_background = false,
				override_terminal = true,
				sign = { color = 'none' },
				float = {
					color = 'mantle',
					invert_border = false,
				},
				completion = {
					color = 'surface0',
				},
			},
			style = {
				tabline = { 'reverse' },
				search = { 'italic', 'reverse' },
				incsearch = { 'italic', 'reverse' },
				types = { 'italic' },
				keyword = { 'italic' },
				comment = { 'italic' },
			},
		}
	},

	{ 'nyoom-engineering/oxocarbon.nvim', priority = 1000 },
})

