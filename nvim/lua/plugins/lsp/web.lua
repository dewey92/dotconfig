local capabilities = require('cmp_nvim_lsp').default_capabilities()

local M = {}

M.setup = function ()
  require('typescript-tools').setup {
    capabilities = capabilities,
    settings = {
      tsserver_format_options = {
        convertTabsToSpaces = false,
        insertSpaceAfterFunctionKeywordForAnonymousFunctions = true,
        semicolons = false,
      },
      tsserver_file_preferences = {
        includeInlayEnumMemberValueHints = true,
        includeInlayFunctionParameterTypeHints = false,
        includeInlayParameterNameHints = 'literals',
        includeInlayParameterNameHintsWhenArgumentMatchesName = false,
        includeInlayPropertyDeclarationTypeHints = false,
        quotePreference = 'single',
      },
    },
    on_attach = function (client)
      if client.config.flags then
        client.config.flags.allow_incremental_sync = true
      end
    end,
  }

  vim.lsp.config('eslint', {
    settings = {
      workingDirectories = { mode = 'auto' },
      useFlatConfig = true,
      --[[ options = {
        overrideConfig = {
          parserOptions = {
            project = { 'tsconfig.json', './**/tsconfig.json' }
          }
        }
      } ]]
    }
  })
  vim.lsp.enable('eslint')

  vim.lsp.config('stylelint_lsp', {
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
  })
  vim.lsp.enable('stylelint_lsp')

  vim.lsp.config('astro', {
    capabilities = capabilities,
    -- root_dir = require('lspconfig.util').root_pattern('astro.config.mjs', '.git'),
  })

  vim.lsp.config('tailwindcss', {
    capabilities = capabilities,
    -- root_dir = require('lspconfig.util').root_pattern('component.json', '.git'),
  })
end

return M
