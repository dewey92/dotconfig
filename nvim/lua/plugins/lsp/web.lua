local nvim_lsp = require('lspconfig')
local null_ls = require('null-ls')

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

  vim.keymap.set('n', '<Leader>cc', tsserver_actions, { silent = true, buffer = bufnr })
end

M.setup = function (on_attach)
  nvim_lsp.tsserver.setup {
    on_attach = function (client, bufnr)
      if client.config.flags then
        client.config.flags.allow_incremental_sync = true
      end

      setup_ts_code_actions(bufnr)

      on_attach(client, bufnr)
    end,
  }

  nvim_lsp.eslint.setup {
    on_attach = on_attach,
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
    --[[ init_options = {
      documentFormatting = true,
    }, ]]
    on_attach = on_attach,
    settings = {
      stylelintplus = {
        autoFixOnSave = true,
        autoFixOnFormat = true,
      }
    },
  }

  null_ls.setup {
    sources = {
      null_ls.builtins.formatting.prettier.with({
        on_attach = on_attach
      })
    }
  }
end

return M
