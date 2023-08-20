local nvim_lsp = require('lspconfig')

local M = {}

M.setup = function()
  nvim_lsp.intelephense.setup {}
end

return M
