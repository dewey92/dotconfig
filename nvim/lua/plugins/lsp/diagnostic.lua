local nvim_lsp = require('lspconfig')

local M = {}

M.setup = function (opt)
  nvim_lsp.diagnosticls.setup {
    filetypes = opt.filetypes,
    init_options = {
      linters = opt.linters,
      filetypes = opt.lintFiletypes,
      formatters = opt.formatters,
      formatFiletypes = opt.formatFiletypes,
    }
  }
end

return M
