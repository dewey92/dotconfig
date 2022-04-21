local utils = require('my.utils')
local nnoremap = utils.nnoremap
local opts = { silent = true }

-- UI
vim.cmd [[autocmd ColorScheme * highlight NormalFloat guibg=#1f2335]]
vim.cmd [[autocmd ColorScheme * highlight FloatBorder guifg=white guibg=#1f2335]]

local border = {
  {'🭽', 'FloatBorder'},
  {'▔', 'FloatBorder'},
  {'🭾', 'FloatBorder'},
  {'▕', 'FloatBorder'},
  {'🭿', 'FloatBorder'},
  {'▁', 'FloatBorder'},
  {'🭼', 'FloatBorder'},
  {'▏', 'FloatBorder'},
}

require'lsp_signature'.setup {
  bind = true, -- This is mandatory, otherwise border config won't get registered.
  handler_opts = {
    border = 'single'
  },
}

require('lspkind').init {}

-- Refocus quickfix list immediately to counter `wincmd p` in the default impl
local orig_handler_references = vim.lsp.handlers['textDocument/references']
vim.lsp.handlers['textDocument/references'] = function (err, method, result)
  orig_handler_references(err, method, result)

  if result ~= nil then
    vim.cmd [[ botright cwindow ]]
  end
end

-- Refocus quickfix list immediately to counter `wincmd p` in the default impl
local function location_handler_focus_qf (handler)
  return function (err, method, result)
    handler(err, method, result)

    if vim.tbl_islist(result) and #result > 1 then
      vim.cmd [[ botright cwindow ]]
    end
  end
end

local function preview_location_callback(_, result)
  if result == nil or vim.tbl_isempty(result) then
    return nil
  end
  vim.lsp.util.preview_location(result[1], { border = border })
end

local function peek_definition()
  local params = vim.lsp.util.make_position_params()
  return vim.lsp.buf_request(0, 'textDocument/definition', params, preview_location_callback)
end

local orig_handler_definition = vim.lsp.handlers['textDocument/definition']
local orig_handler_type_definition = vim.lsp.handlers['textDocument/typeDefinition']
vim.lsp.handlers['textDocument/definition'] = location_handler_focus_qf(orig_handler_definition)
vim.lsp.handlers['textDocument/typeDefinition'] = location_handler_focus_qf(orig_handler_type_definition)
vim.lsp.handlers['textDocument/hover'] =  vim.lsp.with(vim.lsp.handlers.hover, { border = border })
vim.lsp.handlers['textDocument/publishDiagnostics'] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
  virtual_text = true,
  signs = true,
  underline = true,
  update_in_insert = false,
})

local on_attach = function(client, bufnr)
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  local buf_opts = { silent = true, buffer = bufnr }

  -- Mappings
  nnoremap { 'gd', vim.lsp.buf.definition, buf_opts }
  nnoremap { 'gt', vim.lsp.buf.type_definition, buf_opts }
  nnoremap { 'gD', vim.lsp.buf.references, buf_opts }
  nnoremap { 'K', vim.lsp.buf.hover, buf_opts }
  nnoremap { '<Leader>ci', vim.lsp.buf.implementation, buf_opts }
  -- nnoremap { '<C-k>', vim.lsp.buf.signature_help, buf_opts }
  nnoremap { '<Leader>cr', vim.lsp.buf.rename, buf_opts }
  nnoremap { '\\e', function () vim.diagnostic.open_float({ border = border }) end, buf_opts }
  nnoremap { '[e', function () vim.diagnostic.goto_prev({ float = { border = border } }) end, buf_opts }
  nnoremap { ']e', function () vim.diagnostic.goto_next({ float = { border = border } }) end, buf_opts }
  nnoremap { '<Leader>ce', function () vim.diagnostic.setqflist({ namespace = nil }) end, buf_opts }
  nnoremap { '<Leader>cd', peek_definition, buf_opts }
  nnoremap { '<Leader>ca', vim.lsp.buf.code_action, buf_opts }
  nnoremap { '<Leader>si', vim.lsp.buf.workspace_symbol, buf_opts }

  -- Set some keybinds conditional on server capabilities
  if client.resolved_capabilities.document_formatting then
    nnoremap { '<Leader>cf', vim.lsp.buf.formatting, buf_opts }
  elseif client.resolved_capabilities.document_range_formatting then
    nnoremap { '<Leader>cf', vim.lsp.buf.range_formatting, buf_opts }
  end
end

--------------------------------------------------------------------------------
-- LANGUAGE SERVERS
--------------------------------------------------------------------------------
require('plugins.lsp.php').setup(on_attach)
require('plugins.lsp.web').setup(on_attach)
require('plugins.lsp.lua').setup(on_attach)
require('plugins.lsp.purescript').setup(on_attach)
require('plugins.lsp.haskell').setup(on_attach)
require('plugins.lsp.json').setup(on_attach)
