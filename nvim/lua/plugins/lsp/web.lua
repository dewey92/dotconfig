local nvim_lsp = require('lspconfig')
local utils = require('my.utils')
local nnoremap = utils.nnoremap

local M = {}

local function setup_ts_code_actions(bufnr)
  require('nvim-lsp-ts-utils').setup {}

  local function tsserver_actions()
    require('plugins.telescope').run_command({
      prompt_title = 'TsServer Actions',
      commands = {
        { text = 'Organize imports', command = 'TSLspOrganize' },
        { text = 'Fix current', command = 'TSLspFixCurrent' },
        { text = 'Rename file', command = 'TSLspRenameFile' },
        { text = 'Import all', command = 'TSLspImportAll' },
        { text = 'Format file (eslint, stylelint)', command = 'lua vim.lsp.buf.formatting()' },
      }
    })
  end

  nnoremap { '<Leader>cc', tsserver_actions, { silent = true, buffer = bufnr } }
end

M.setup = function (on_attach)
  nvim_lsp.tsserver.setup {
    --[[ init_options = {
      documentFormatting = false,
    }, ]]
    on_attach = function (client, bufnr)
      client.server_capabilities.document_formatting = true
      if client.config.flags then
        client.config.flags.allow_incremental_sync = true
      end

      setup_ts_code_actions(bufnr)

      on_attach(client, bufnr)
    end,
  }

  nvim_lsp.eslint.setup {
    on_attach = function (client, bufnr)
      client.server_capabilities.document_formatting = true
      on_attach(client, bufnr)
    end,
    --[[ init_options = {
      documentFormatting = true,
    }, ]]
    settings = {
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
    on_attach = function (client)
      client.server_capabilities.document_formatting = true
    end,
    settings = {
      stylelintplus = {
        autoFixOnSave = true,
        autoFixOnFormat = true,
      }
    },
  }
end

return M
