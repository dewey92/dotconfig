local nvim_lsp = require('lspconfig')

local M = {}

M.setup = function()
  nvim_lsp.purescriptls.setup {
    settings = {
      purescript = {
        addSpagoSources = true -- e.g. any purescript language-server config here
      }
    },
  }
end

return M
