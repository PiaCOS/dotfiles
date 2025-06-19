local M = {}

function M.setup()
  local lspconfig = require("lspconfig")
  local lspconfigs = require("lspconfig.configs")

  -- Register odoo_lsp manually if not already registered
  if not lspconfigs.odoo_lsp then
    lspconfigs.odoo_lsp = {
      default_config = {
        name = "odoo-lsp",
        cmd = { "odoo-lsp" },
        filetypes = { "python", "javascript", "xml" },
        root_dir = require("lspconfig.util").root_pattern(".odoo_lsp", ".odoo_lsp.json", ".git"),
      },
    }
  end

  -- Setup odoo_lsp
  lspconfig.odoo_lsp.setup({})
end

return M

