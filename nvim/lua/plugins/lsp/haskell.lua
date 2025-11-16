local nvim_lsp = vim.lsp.config

local M = {}

M.setup = function()
  nvim_lsp('hls', {
    settings = {
      haskell = {
        formattingProvider = 'fourmolu',
      },
    },
  })
end

return M
