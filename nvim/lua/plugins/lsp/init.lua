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

vim.lsp.handlers['textDocument/hover'] =  vim.lsp.with(vim.lsp.handlers.hover, { border = border })
vim.lsp.handlers['textDocument/publishDiagnostics'] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
  virtual_text = true,
  signs = true,
  underline = true,
  update_in_insert = false,
})

vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('MyLspCapabilities', {}),
  callback = function(ev)
    local bufnr = ev.buf
    local client = vim.lsp.get_client_by_id(ev.data.client_id)

    if client == nil then return end

    if client.server_capabilities.inlayHintProvider then
      vim.lsp.inlay_hint(bufnr, true)
    end
  end,
})

vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('MyLspKeymaps', {}),
  callback = function(ev)
    -- Enable completion
    vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

    -- Buffer local mappings.
    local function map(mode, l, r, opts)
      opts = opts or {}
      opts.buffer = ev.buf
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
    map('n', '<Leader>ce',
      function () vim.diagnostic.setqflist({ severity = vim.diagnostic.severity.ERROR }) end,
      { desc = 'List errors' }
    )
    map('n', '<Leader>cd', peek_definition, { desc = 'Peek definition' })
    map('n', '<Leader>ca', vim.lsp.buf.code_action, { desc = 'Code actions' })
    map('n', '<Leader>si', vim.lsp.buf.workspace_symbol, { desc = 'Search symbol' })

    map('n', '<Leader>cf', function () vim.lsp.buf.format { async = true } end, { desc = 'Format buffer' })
    map({ 'v', 'x' }, '<Leader>cf', function () vim.lsp.buf.format { async = true } end, { desc = 'Range format' })
  end,
})

--------------------------------------------------------------------------------
-- LANGUAGE SERVERS
--------------------------------------------------------------------------------
require('plugins.lsp.php').setup()
require('plugins.lsp.web').setup()
require('plugins.lsp.lua').setup()
require('plugins.lsp.purescript').setup()
require('plugins.lsp.haskell').setup()
require('plugins.lsp.json').setup()
