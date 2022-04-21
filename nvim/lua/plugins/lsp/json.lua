local nvim_lsp = require('lspconfig')

local M = {}

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

M.setup = function(on_attach)
  nvim_lsp.jsonls.setup {
    on_attach = on_attach,
    capabilities = capabilities,
    settings = {
      json = {
        schemas = require('schemastore').json.schemas(),
      },
    },
  }
end

return M
