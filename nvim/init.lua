require('my.plugins')
require('my.config')
require('my.appearances')
require('my.languages')

vim.api.nvim_exec([[
  source $HOME/.config/nvim/mappings.vim
]], false)
