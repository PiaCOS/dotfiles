return {
  "nvim-lua/plenary.nvim", -- just a placeholder to hook into LazyVim’s lazy loader
  init = function()
    local visible = false

    function ToggleWhitespace()
      if visible then
        vim.opt.list = false
        visible = false
      else
        vim.opt.list = true
        vim.opt.listchars = {
          tab = '▸ ',
          trail = '·',
          extends = '⟩',
          precedes = '⟨',
          nbsp = '␣',
        }
        visible = true
      end
    end

    vim.keymap.set("n", "<leader>w", ToggleWhitespace, { desc = "Toggle visible whitespace" })
  end,
}
