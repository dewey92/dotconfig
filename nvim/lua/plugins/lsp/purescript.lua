local nvim_lsp = vim.lsp.config

local M = {}

M.setup = function()
  nvim_lsp('purescriptls', {
    settings = {
      purescript = {
        addSpagoSources = true -- e.g. any purescript language-server config here
      }
    },
  })
end

return M
