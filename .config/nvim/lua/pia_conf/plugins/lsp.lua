local M = {}

local on_attach = function(client, bufnr)
  -- Enable diagnostic visuals
  vim.diagnostic.config({
    virtual_text = true,
    signs = true,
    underline = true,
    update_in_insert = false,
    severity_sort = true,
  })

  local opts = { noremap=true, silent=true }
  local keymap = vim.api.nvim_buf_set_keymap

  keymap(bufnr, "n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
  keymap(bufnr, "n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
  keymap(bufnr, "n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
  keymap(bufnr, "i", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
  keymap(bufnr, "n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
  keymap(bufnr, "n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
  keymap(bufnr, "n", "<leader>f", "<cmd>lua vim.lsp.buf.format{ async = true }<CR>", opts)
end

function M.setup()
  local lspconfig = require("lspconfig")

  local servers = {
    "ts_ls",
    "pyright",
    "rust_analyzer",
    "lua_ls",
		"lemminx",
  }

  for _, server in ipairs(servers) do
    if server == "lua_ls" then
      lspconfig.lua_ls.setup {
        on_attach = on_attach,
        settings = {
          Lua = {
            diagnostics = { globals = { "vim" } },
          },
        },
      }
    else
      lspconfig[server].setup {
        on_attach = on_attach,
      }
    end
  end
end

return M
