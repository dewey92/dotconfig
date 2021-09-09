local utils = require('my.utils')
local g = vim.g

g.mapleader = ' '

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
  mouse = 'a',
  pumheight = 10,
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
  list = true,
  -- listchars = [[extends:❯,precedes:❮]],
  shiftwidth = 2,
  showtabline = 0,
  smarttab = true,
  tabstop = 2,
}
utils.apply_options(tabs_options)
vim.cmd [[set listchars=tab:▸\ ,extends:❯,precedes:❮]]

vim.api.nvim_exec([[
  filetype plugin indent on
  augroup fts
    au!
    autocmd FileType vim        setlocal expandtab shiftwidth=2 softtabstop=2 tabstop=2
    autocmd FileType purescript setlocal expandtab shiftwidth=2 softtabstop=2 tabstop=2
    autocmd FileType haskell    setlocal expandtab shiftwidth=2 softtabstop=2 tabstop=2
    autocmd FileType cabal      setlocal expandtab shiftwidth=2 softtabstop=2 tabstop=2
    autocmd FileType lua        setlocal expandtab shiftwidth=2 softtabstop=2 tabstop=2
    autocmd FileType markdown   setlocal expandtab shiftwidth=2 softtabstop=2 tabstop=2 wrap linebreak
  augroup END
]], false)

-- Guide indentations
g.indentguides_spacechar = '│'
g.indentguides_tabchar = '▸'
-- g.indent_blankline_char = '│'
-- g.indent_blankline_show_first_indent_level = false
-- g.indent_blankline_use_treesitter = true
-- g.indent_blankline_show_current_context = false -- Set to false when too slow


--------------------------------------------------------------------------------
-- ETC
--------------------------------------------------------------------------------
-- @see https://gist.github.com/romainl/56f0c28ef953ffc157f36cc495947ab3
vim.api.nvim_exec([[
  augroup AutoOpenQf
    au!
    au QuickFixCmdPost [^l]* botright cwindow
    au QuickFixCmdPost l* lwindow
  augroup END
]], false)

vim.api.nvim_exec([[
  augroup ExpandActiveWin
    au!
    au WinEnter * :call ResizeSplits()
  augroup END

  function! ResizeSplits()
    set winwidth=125
    wincmd =
  endfunction
]], false)
