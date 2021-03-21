require('plugins')
require('config')
require('appearances')
require('languages')

vim.api.nvim_exec([[
	source $HOME/.config/nvim/mappings.vim
]], false)

-- Packages configs
require('plugins/telescope')
require('plugins/treesitter')
