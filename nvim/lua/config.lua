local utils = require('utils')
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
	hidden = true,
	mouse = 'a',
	pumheight = 10,
	smartindent = true,
	splitbelow = true,
	splitright = true,
	so = 10,                   -- Scroll offset
	signcolumn = 'yes',
	timeoutlen = 500,          -- Defaults to 1000
	updatetime = 300,          -- Faster completion
	wrap = false,
}
utils.apply_options(general_options)

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

vim.api.nvim_exec([[
	filetype plugin indent on
	autocmd FileType vim setlocal expandtab shiftwidth=2 softtabstop=2 tabstop=2
	autocmd FileType purescript setlocal expandtab shiftwidth=2 softtabstop=2 tabstop=2
	autocmd FileType haskell setlocal expandtab shiftwidth=2 softtabstop=2 tabstop=2
	autocmd FileType markdown setlocal expandtab shiftwidth=2 softtabstop=2 tabstop=2 wrap linebreak
]], false)

-- Guide indentations
g.indentguides_spacechar = '|'
g.indentguides_tabchar = '▸'
