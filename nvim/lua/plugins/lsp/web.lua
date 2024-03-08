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
          includeInlayParameterNameHints = 'literals',
          includeInlayParameterNameHintsWhenArgumentMatchesName = false,
          includeInlayPropertyDeclarationTypeHints = false,
        },
      },
    },
    on_attach = function (client)
      if client.config.flags then
        client.config.flags.allow_incremental_sync = true
      end

      require('nvim-lsp-ts-utils').setup {}
    end,
  }

  nvim_lsp.eslint.setup {
    -- root_dir = require('lspconfig.util').root_pattern('.git'),
    settings = {
      experimental = {
        useFlatConfig = false,
      },
      options = {
        overrideConfig = {
          parserOptions = {
            project = { './**/tsconfig.json' }
          }
        }
      }
    }
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
