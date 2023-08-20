local nvim_lsp = require('lspconfig')

local M = {}

M.setup = function ()
  nvim_lsp.tsserver.setup {
    init_options = {
      preferences = {
        quotePreference = 'single',
      }
    },
    settings = {
      typescript = {
        format = {
          convertTabsToSpaces = false,
          insertSpaceAfterFunctionKeywordForAnonymousFunctions = true,
        },
        inlayHints = {
          includeInlayEnumMemberValueHints = true,
          includeInlayFunctionParameterTypeHints = false,
          includeInlayParameterNameHints = 'all',
          includeInlayParameterNameHintsWhenArgumentMatchesName = false,
          includeInlayPropertyDeclarationTypeHints = true,
        },
      },
    },
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
