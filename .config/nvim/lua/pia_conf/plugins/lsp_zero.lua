local M = {}

function M.setup()
  local lsp = require('lsp-zero').preset({})

  lsp.on_attach(function(_, bufnr)
    lsp.default_keymaps({ buffer = bufnr })
  end)

  local lspconfigs = require 'lspconfig.configs'

  -- Register odoo-lsp manually
  if not lspconfigs.odoo_lsp then
    lspconfigs.odoo_lsp = {
      default_config = {
        name = 'odoo-lsp',
        cmd = { 'odoo-lsp' },
        filetypes = { 'javascript', 'xml', 'python' },
        root_dir = require('lspconfig.util').root_pattern('.odoo_lsp', '.odoo_lsp.json', '.git'),
      },
    }
  end

  local configured_lsps = {
    odoo_lsp = {},
    -- Optional:
    -- pyright = {},
    -- tsserver = {},
    -- lemminx = {},
  }

  local lspconfig = require 'lspconfig'
  for name, config in pairs(configured_lsps) do
    lspconfig[name].setup(config)
  end

  -- Completion mapping for luasnip tabs
  local cmp_action = require('lsp-zero').cmp_action()
  require('cmp').setup {
    mapping = {
      ['<Tab>'] = cmp_action.luasnip_supertab(),
      ['<S-Tab>'] = cmp_action.luasnip_shift_supertab(),
    },
  }
end

return M

