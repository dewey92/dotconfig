local nvim_lsp = require('lspconfig')

local M = {}

M.setup = function()
  nvim_lsp.hls.setup {
    settings = {
      haskell = {
        formattingProvider = 'fourmolu',
      },
    },
  }
end

return M
