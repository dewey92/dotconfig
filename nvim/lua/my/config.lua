local utils = require('my.utils')
local g = vim.g

g.mapleader = ' '
g.editorconfig = false

--------------------------------------------------------------------------------
-- GENERAL
--------------------------------------------------------------------------------
local general_options = {
  autoindent = true,
  clipboard = 'unnamedplus',
  cmdheight = 1,
  conceallevel = 0,
  encoding = 'utf-8',
  fileencoding = 'utf-8',
  grepprg = 'rg --vimgrep --no-heading --smart-case',
  grepformat = '%f:%l:%c:%m,%f:%l:%m',
  hidden = true,
  ignorecase = true,
  laststatus = 3,
  mouse = 'a',
  pumheight = 10,
  smartcase = true,
  smartindent = true,
  splitbelow = true,
  splitright = true,
  signcolumn = 'yes',
  timeoutlen = 500,          -- Defaults to 1000
  updatetime = 300,          -- Faster completion
  wrap = false,
}
utils.apply_options(general_options)

vim.go.scrolloff = 10

vim.cmd [[ set fillchars+=diff:╱ ]]

--------------------------------------------------------------------------------
-- TABS, SPACE, INDENTATIONS
--------------------------------------------------------------------------------
local tabs_options = {
  expandtab = true, -- use space instead of tab
  list = true,
  shiftwidth = 2,
  showtabline = 0,
  smarttab = true,
  softtabstop = 2,
  tabstop = 2,
}
utils.apply_options(tabs_options)

vim.opt.listchars = {
  -- tab = '▸ ',
  tab = '  ',
  extends = '❯',
  precedes = '❮',
  -- eol = '↴',
  -- lead = '·',
}

vim.cmd [[
  filetype plugin indent on
  augroup fts
    au!
    au FileType php             setlocal noexpandtab
    au FileType smarty          setlocal noexpandtab
    au FileType typescript      setlocal noexpandtab
    au FileType typescriptreact setlocal noexpandtab
    au FileType javascript      setlocal noexpandtab
    au FileType markdown        setlocal expandtab wrap linebreak
  augroup END
]]

require('my.search')
