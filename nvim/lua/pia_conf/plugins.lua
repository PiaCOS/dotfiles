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

		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope-live-grep-args.nvim",
		},

		opts = function(_, opts)
			local lga_actions = require("telescope-live-grep-args.actions")
			local vertical_layout = {
				width = 0.8,
				height = 0.8,
				mirror = true,
			}
			opts.defaults = vim.tbl_deep_extend("force", opts.defaults or {}, {
				layout_strategy = "vertical",
				layout_config = vertical_layout,
				winblend = 10,
				previewer = false,
			})
			opts.extensions = {
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
			}
		end,

		keys = {
			{
				"<leader>fF",
				function() require("telescope.builtin").find_files() end,
				desc = "Find files",
			},
			{
				"<leader>fG",
				function() require("telescope").extensions.live_grep_args.live_grep_args() end,
				desc = "Grep (live with args)"
			},
		},

		config = function(_, opts)
			local tele = require("telescope")
			tele.setup(opts)
			tele.load_extension("live_grep_args")
		end,
	},

	--fzf-lua
	{
		"ibhagwan/fzf-lua",
		dependencies = { "nvim-tree/nvim-web-devicons" }, -- optional, icons~
		keys = {
			{
				"<leader>fg",
				function()
					require("fzf-lua").live_grep_glob()
				end,
				desc = "FZF-Lua Grep"
			},
			{
				"<leader>ff",
				function()
					require("fzf-lua").files()
				end,
				desc = "FZF-Lua Files"
			},
		},
		config = function()
			require("fzf-lua").setup({
				"default", -- or "telescope" for telescope-like theme
				winopts = {
					height = 0.85,
					width = 0.80,
					preview = {
						layout = "vertical",
					},
				},
				grep = {
					rg_opts = "--hidden --column --line-number --no-heading --color=always --smart-case -e",
					prompt = '🔍> ',
				},
			})
		end,
	},


	-- Treesitter
	{
		'nvim-treesitter/nvim-treesitter',
		build = ':TSUpdate',
		config = function()
			require'nvim-treesitter.configs'.setup {
				ensure_installed = { "javascript", "typescript", "lua", "json", "python", "rust", "fish", "xml" }, -- add more if needed
				highlight = {
					enable = true,
					disable = { "markdown", },
					additional_vim_regex_highlighting = false, -- usually leave this false unless you need legacy stuff
				},
			}
		end
	},
})

