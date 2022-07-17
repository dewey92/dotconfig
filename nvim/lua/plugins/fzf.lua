local fzf = require('fzf-lua')

local function find_sibling_files ()
  fzf.files {
    cwd = vim.fn.expand('%:p:h'),
    prompt = 'Sibling Files❯ ',
  }
end

local function find_nvim_config_files ()
  fzf.files {
    cwd = '~/.config/nvim',
    prompt = 'Neovim Files❯ ',
  }
end

local function find_config_files ()
  fzf.files {
    cwd = '~/.config',
    prompt = 'Config Files❯ ',
  }
end

require('fzf-lua').setup {
  winopts = {
    hl = { border = 'FloatBorder' }
  }
}

--------------------------------------------------------------------------------
-- Mappings
--------------------------------------------------------------------------------
local utils = require('my.utils')
local nnoremap = utils.nnoremap
local xnoremap = utils.xnoremap
local opts = { silent = true }

nnoremap { '<Leader><Leader>', fzf.git_files, opts }
nnoremap { '<Leader>,', fzf.files, opts }
nnoremap { '<Leader>.', find_sibling_files, opts }
nnoremap { '<Leader>bb', fzf.buffers, opts }
nnoremap { '<Leader>fp', find_nvim_config_files, opts }
nnoremap { '<Leader>fP', find_config_files, opts }

nnoremap { '<Leader>sp', fzf.live_grep, opts }
xnoremap { '<Leader>sp', fzf.grep_visual, opts }
nnoremap { '<Leader>sb', fzf.grep_curbuf, opts }

nnoremap { '<Leader>ht', fzf.colorschemes, opts }
nnoremap { '<Leader>hh', fzf.help_tags, opts }
nnoremap { '<Leader>:', fzf.commands, opts }
nnoremap { '<Leader>;', fzf.commands, opts }
