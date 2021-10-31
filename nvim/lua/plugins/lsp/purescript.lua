local nvim_lsp = require('lspconfig')

local M = {}

M.setup = function(on_attach)
  nvim_lsp.purescriptls.setup {
    on_attach = on_attach,
    settings = {
      purescript = {
        addSpagoSources = true -- e.g. any purescript language-server config here
      }
    },
  }
end

return M
