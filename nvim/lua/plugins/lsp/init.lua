local k = require('astronauta.keymap')
local nnoremap, vnoremap = k.nnoremap, k.vnoremap
local opts = { silent = true }

local on_attach = function(client, bufnr)
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  local buf_opts = { silent = true, buffer = bufnr }

  -- Mappings
  nnoremap { 'gd', vim.lsp.buf.definition, buf_opts }
  nnoremap { 'gt', vim.lsp.buf.type_definition, buf_opts }
  nnoremap { 'gD', vim.lsp.buf.references, buf_opts }
  -- nnoremap { 'K', vim.lsp.buf.hover, buf_opts }
  -- nnoremap { 'gi', vim.lsp.buf.implementation, buf_opts }
  -- nnoremap { '<C-k>', vim.lsp.buf.signature_help, buf_opts }
  nnoremap { '<Leader>cr', vim.lsp.buf.rename, buf_opts }
  -- nnoremap { '<space>ce', vim.lsp.diagnostic.show_line_diagnostics, buf_opts }
  -- nnoremap { '[e', vim.lsp.diagnostic.goto_prev, buf_opts }
  -- nnoremap { ']e', vim.lsp.diagnostic.goto_next, buf_opts }
  nnoremap { '<Leader>ce', vim.lsp.diagnostic.set_loclist, buf_opts }
  nnoremap { '<Leader>si', vim.lsp.buf.workspace_symbol, buf_opts }

  -- Set some keybinds conditional on server capabilities
  if client.resolved_capabilities.document_formatting then
    nnoremap { '<Leader>cf', vim.lsp.buf.formatting, buf_opts }
  elseif client.resolved_capabilities.document_range_formatting then
    nnoremap { '<Leader>cf', vim.lsp.buf.range_formatting, buf_opts }
  end
end

-- Refocus quickfix list immediately to counter `wincmd p` in the default impl
local orig_handler_references = vim.lsp.handlers['textDocument/references']
vim.lsp.handlers['textDocument/references'] = function (err, method, result)
  orig_handler_references(err, method, result)

  if result ~= nil then
    vim.cmd [[ copen ]]
    vim.cmd [[ wincmd J ]]
  end
end

-- Refocus quickfix list immediately to counter `wincmd p` in the default impl
local function location_handler_focus_qf (handler)
  return function (err, method, result)
    handler(err, method, result)

    if vim.tbl_islist(result) and #result > 1 then
      vim.cmd [[ copen ]]
      vim.cmd [[ wincmd J ]]
    end
  end
end

local orig_handler_definition = vim.lsp.handlers['textDocument/definition']
local orig_handler_type_definition = vim.lsp.handlers['textDocument/typeDefinition']
vim.lsp.handlers['textDocument/definition'] = location_handler_focus_qf(orig_handler_definition)
vim.lsp.handlers['textDocument/typeDefinition'] = location_handler_focus_qf(orig_handler_type_definition)

-- @see: https://github.com/neovim/nvim-lspconfig/issues/516
vim.cmd([[
  augroup MyLspSignsHi
    autocmd!
    autocmd BufEnter * :lua require('vim.lsp.diagnostic')._define_default_signs_and_highlights()
  augroup END
]])

--------------------------------------------------------------------------------
-- LANGUAGE SERVERS
--------------------------------------------------------------------------------
require('plugins.lsp.php').setup(on_attach)
require('plugins.lsp.web').setup(on_attach)
require('plugins.lsp.lua').setup(on_attach)
require('plugins.lsp.purescript').setup(on_attach)
require('plugins.lsp.haskell').setup(on_attach)

local web_diagnostic = require('plugins.lsp.web').get_diagnostic()
require('plugins.lsp.diagnostic').setup(web_diagnostic)

--------------------------------------------------------------------------------
-- ICONS yeaaah~~
--------------------------------------------------------------------------------
require('lspkind').init {}

--------------------------------------------------------------------------------
-- LSP SAGA
--------------------------------------------------------------------------------
require('lspsaga').init_lsp_saga {}
local codeaction = require('lspsaga.codeaction')
-- local rename = require('lspsaga.rename') -- @see https://github.com/glepnir/lspsaga.nvim/issues/186
local provider = require('lspsaga.provider')
local diagnostic = require('lspsaga.diagnostic')
local hover = require('lspsaga.hover')

nnoremap { '<Leader>ca', codeaction.code_action, opts }
vnoremap { '<Leader>ca', codeaction.range_code_action, opts }
-- nnoremap {'<Leader>cr', rename.rename, opts }
nnoremap { '<Leader>cd', provider.preview_definition, opts }
nnoremap { '<Leader>cj', provider.lsp_finder, opts }

nnoremap { '[e', diagnostic.lsp_jump_diagnostic_prev, opts }
nnoremap { ']e', diagnostic.lsp_jump_diagnostic_next, opts }
nnoremap { 'K', hover.render_hover_doc, opts }
