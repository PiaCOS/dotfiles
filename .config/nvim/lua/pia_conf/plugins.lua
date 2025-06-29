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

	{
		"nvim-treesitter/playground",
		cmd = { "TSPlaygroundToggle", "TSHighlightCapturesUnderCursor" },
		config = function()
			require("nvim-treesitter.configs").setup {
				playground = {
					enable = true,
					updatetime = 25,
					persist_queries = false,
				},
			}
		end
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
  'everviolet/nvim',
		name = 'evergarden',
		priority = 1000,
		config = function()
			local colors = require("evergarden.colors").colors

			require('evergarden').setup {
				theme = {
					variant = 'spring',
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
				overrides = {
					["@string"] = { fg = colors.lime, italic = true },
					["@function"] = { fg = colors.green, italic = true },
				},
			}

			vim.cmd.colorscheme("evergarden")
		end
	},


	{ 'nyoom-engineering/oxocarbon.nvim', priority = 1000 },
})

