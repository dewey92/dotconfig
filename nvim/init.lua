require('plugins')
require('config')
require('appearances')
require('languages')

vim.api.nvim_exec([[
	source $HOME/.config/nvim/mappings.vim
]], false)

-- Packages configs
vim.api.nvim_exec([[
	source $HOME/.config/nvim/packages/coc.vim
	source $HOME/.config/nvim/packages/hop.vim
	source $HOME/.config/nvim/packages/floaterm.vim
	source $HOME/.config/nvim/packages/gitgutter.vim
]], false)
require('plugins/telescope')
require('plugins/treesitter')
