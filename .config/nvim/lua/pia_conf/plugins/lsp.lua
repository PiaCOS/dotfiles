local M = {}

local on_attach = function(_, bufnr)
  local keymap = vim.api.nvim_buf_set_keymap
  local opts = { noremap = true, silent = true }
  
	keymap(bufnr, "n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)

end

vim.diagnostic.config({
  virtual_text = true,
  signs = true,
  underline = true,
  update_in_insert = false,
  severity_sort = true,
})

function M.setup()
  local lspconfig = require("lspconfig")
  local mason_lspconfig = require("mason-lspconfig")

  mason_lspconfig.setup({
		handlers = {
			function(server_name)
				lspconfig[server_name].setup({
					on_attach = on_attach,
				})
			end,

			["lua_ls"] = function() -- it's an overide of lua_ls because of "undefined global 'vim'"
				lspconfig.lua_ls.setup({
					on_attach = on_attach,
					settings = {
						Lua = {
							diagnostics = {
								globals = { "vim" },
							},
						},
					},
				})
			end,
  	}
	})
end

return M
