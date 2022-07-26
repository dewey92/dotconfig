-- UI
vim.cmd [[autocmd ColorScheme * highlight NormalFloat guibg=#1f2335]]
vim.cmd [[autocmd ColorScheme * highlight FloatBorder guifg=white guibg=#1f2335]]

local border = 'rounded'

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

  local function map(mode, l, r, opts)
    opts = opts or {}
    opts.buffer = bufnr
    opts.silent = true
    vim.keymap.set(mode, l, r, opts)
  end

  -- Mappings
  map('n', 'gd', vim.lsp.buf.definition, { desc = 'Go to definition' })
  map('n', 'gD', function () vim.cmd('vsplit'); vim.lsp.buf.definition() end, { desc = 'Go to definition in vsplit' })
  map('n', 'gt', vim.lsp.buf.type_definition, { desc = 'Go to type definition' })
  map('n', 'gr', vim.lsp.buf.references, { desc = 'References' })
  map('n', 'K', vim.lsp.buf.hover)
  map('n', '<Leader>ci', vim.lsp.buf.implementation, { desc = 'See implementation' })
  -- nnoremap { '<C-k>', vim.lsp.buf.signature_help, buf_opts }
  map('n', '<Leader>cr', vim.lsp.buf.rename, { desc = 'Rename' })
  map('n', '\\e', function () vim.diagnostic.open_float({ border = border }) end, { desc = 'See error' })
  map('n', '[e', function () vim.diagnostic.goto_prev({ float = { border = border } }) end, { desc = 'Prev error' })
  map('n', ']e', function () vim.diagnostic.goto_next({ float = { border = border } }) end, { desc = 'Next error' })
  map( 'n', '<Leader>ce',
    function () vim.diagnostic.setqflist({ severity = vim.diagnostic.severity.ERROR }) end,
    { desc = 'List errors' }
  )
  map('n', '<Leader>cd', peek_definition, { desc = 'Peek definition' })
  map('n', '<Leader>ca', vim.lsp.buf.code_action, { desc = 'Code actions' })
  map('n', '<Leader>si', vim.lsp.buf.workspace_symbol, { desc = 'Search symbol' })

  -- Set some keybinds conditional on server capabilities
  if client.server_capabilities.documentFormattingProvider then
    map('n', '<Leader>cf', function () vim.lsp.buf.format({ async = true }) end, { desc = 'Format buffer' })
  elseif client.server_capabilities.documentRangeFormattingProvider then
    map({ 'v', 'x' }, '<Leader>cf', vim.lsp.buf.range_formatting, { desc = 'Range format' })
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
