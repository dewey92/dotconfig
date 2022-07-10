local nvim_lsp = require('lspconfig')
local utils = require('my.utils')
local nnoremap = utils.nnoremap

local M = {}

local function setup_ts_code_actions(bufnr)
  require('nvim-lsp-ts-utils').setup {}

  local commands = {
    ['Organize imports'] = 'TSLspOrganize',
    ['Rename file'] = 'TSLspRenameFile',
    ['Import all'] = 'TSLspImportAll',
    ['Format file (eslint, stylelint)'] = 'lua vim.lsp.buf.formatting()',
  }

  local function tsserver_actions()
    --[[ require('plugins.telescope').run_command({
      prompt_title = 'TsServer Actions',
      commands = commands
    }) ]]
    vim.ui.select(vim.tbl_keys(commands), {
      prompt = 'TS Server Actions:'
    }, function (item)
      if item == nil then return end

      vim.cmd(commands[item])
    end)
  end

  nnoremap { '<Leader>cc', tsserver_actions, { silent = true, buffer = bufnr } }
end

M.setup = function (on_attach)
  nvim_lsp.tsserver.setup {
    on_attach = function (client, bufnr)
      client.server_capabilities.documentFormattingProvider = true
      if client.config.flags then
        client.config.flags.allow_incremental_sync = true
      end

      setup_ts_code_actions(bufnr)

      on_attach(client, bufnr)
    end,
  }

  nvim_lsp.eslint.setup {
    on_attach = function (client, bufnr)
      client.server_capabilities.documentFormattingProvider = true
      on_attach(client, bufnr)
    end,
    root_dir = require('lspconfig.util').root_pattern('.git')
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
    on_attach = function (client)
      client.server_capabilities.documentFormattingProvider = true
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
