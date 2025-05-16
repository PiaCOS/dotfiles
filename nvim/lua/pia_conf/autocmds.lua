-- lua/pia_conf/autocmds.lua

-- tab spaces
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "fish", "python", "javascript", "markdown", "text" },
  callback = function()
    vim.opt_local.tabstop = 4
    vim.opt_local.shiftwidth = 4
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "lua" },
  callback = function()
    vim.opt_local.tabstop = 2
    vim.opt_local.shiftwidth = 2
  end,
})

