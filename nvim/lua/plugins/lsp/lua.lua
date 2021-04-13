local nvim_lsp = require('lspconfig')

local M = {}

M.setup = function(on_attach)
  local sumneko_root = os.getenv('HOME')..'/Projects/lua-language-server'
  nvim_lsp.sumneko_lua.setup {
    cmd = {
      sumneko_root .. '/bin/Linux/lua-language-server',
      '-E',
      sumneko_root .. '/main.lua',
    },
    on_attach = on_attach,
    settings = {
      Lua = {
        runtime = { version = 'LuaJIT', path = vim.split(package.path, ';') },
        diagnostics = {
          enable = true,
          globals = {'vim'},
        },
        workspace = {
          -- Make the server aware of Neovim runtime files
          library = {
            [vim.fn.expand('$VIMRUNTIME/lua')] = true,
            [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true,
          },
        },
      },
    },
  }
end

return M
