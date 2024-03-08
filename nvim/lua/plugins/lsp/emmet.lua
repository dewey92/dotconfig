local nvim_lsp = require('lspconfig')
local emmet_ls = require('lspconfig.server_configurations.emmet_ls')

local M = {}

M.setup = function ()
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities.textDocument.completion.completionItem.snippetSupport = true

  nvim_lsp.emmet_ls.setup({
    capabilities = capabilities,
    filetypes = table.insert(emmet_ls.default_config.filetypes, 'markdown'),
    init_options = {
      html = {
        options = {
          -- For possible options, see: https://github.com/emmetio/emmet/blob/master/src/config.ts#L79-L267
          ['bem.enabled'] = true,
        },
      },
    }
  })
end

return M
