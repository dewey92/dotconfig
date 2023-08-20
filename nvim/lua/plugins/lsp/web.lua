local nvim_lsp = require('lspconfig')

local M = {}

M.setup = function ()
  nvim_lsp.tsserver.setup {
    on_attach = function (client)
      if client.config.flags then
        client.config.flags.allow_incremental_sync = true
      end
    end,
  }

  nvim_lsp.eslint.setup {
    root_dir = require('lspconfig.util').root_pattern('.git'),
    --[[ settings = {
      options = {
        overrideConfig = {
          parserOptions = {
            project = { './**/tsconfig.json' }
          }
        }
      }
    } ]]
  }

  nvim_lsp.stylelint_lsp.setup {
    --[[ init_options = {
      documentFormatting = true,
    }, ]]
    settings = {
      stylelintplus = {
        autoFixOnSave = true,
        autoFixOnFormat = true,
        validateOnSave = true,
      }
    },
  }
end

return M
