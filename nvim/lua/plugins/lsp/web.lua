local nvim_lsp = require('lspconfig')
local k = require('astronauta.keymap')
local nnoremap = k.nnoremap

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
    init_options = {
      documentFormatting = false,
    },
    on_attach = function(client, bufnr)
      if client.config.flags then
        client.config.flags.allow_incremental_sync = true
      end

      setup_ts_code_actions(bufnr)

      on_attach(client)
    end
  }

  nvim_lsp.stylelint_lsp.setup {
    init_options = {
      documentFormatting = true,
    },
    -- FIXME: Not sure why these are not working
    settings = {
      autoFixOnSave = true,
      autoFixOnFormat = true,
    },
  }
end

M.get_diagnostic = function ()
  local D = {}

  D.linters = {
    eslint = {
      sourceName = 'eslint',
      command = 'eslint_d',
      args = {'--stdin', '--stdin-filename', '%filepath', '--format', 'json'},
      rootPatterns = {'.git', '.eslintrc.*', 'package.json'},
      debounce = 100,
      parseJson = {
        errorsRoot = '[0].messages',
        line = 'line',
        column = 'column',
        endLine = 'endLine',
        endColumn = 'endColumn',
        message = '${message} [${ruleId}]',
        security = 'severity'
      },
      securities = {[2] = 'error', [1] = 'warning'}
    },
  }
  D.lintFiletypes = {
    typescript = {'eslint'},
    typescriptreact = {'eslint'},
  }
  D.formatters = {
    eslint = {
      command = 'eslint',
      args = {'--fix', '%filepath'},
    },
    stylelint = {
      command = 'stylelint',
      args = {'--fix', '--stdin', '--stdin-filename', '%filepath'},
    }
  }
  D.formatFiletypes = {
    typescript = {'eslint', 'stylelint'},
    typescriptreact = {'eslint', 'stylelint'},
  }
  D.filetypes = vim.tbl_keys(D.lintFiletypes)

  return D
end

return M
