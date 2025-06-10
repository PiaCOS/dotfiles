-- INIT.LUA

vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.cmd("set number")
vim.cmd("set relativenumber")

require("pia_conf.options")
require("pia_conf.autocmds")
require("pia_conf.plugins")
require("pia_conf.theme")
require("pia_conf.keymaps")

require("pia_conf.livegrep")
