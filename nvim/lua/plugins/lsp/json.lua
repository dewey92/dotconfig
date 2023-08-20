local nvim_lsp = require('lspconfig')

local M = {}

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

M.setup = function()
  nvim_lsp.jsonls.setup {
    capabilities = capabilities,
    settings = {
      json = {
        schemas = require('schemastore').json.schemas(),
      },
    },
  }
end

return M
