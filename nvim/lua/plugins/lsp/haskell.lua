local nvim_lsp = require('lspconfig')

local M = {}

M.setup = function(on_attach)
  nvim_lsp.hls.setup { on_attach = on_attach }
end

return M
