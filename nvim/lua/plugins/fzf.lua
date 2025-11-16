local fzf = require('fzf-lua')
local actions = require('fzf-lua.actions')
local defaults = require('fzf-lua.defaults').defaults
local my_search = require('my.search')

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
  hls = { border = 'FloatBorder' },
  actions = {
    files = vim.tbl_extend('force', defaults.actions.files, {
      ["alt-q"] = function (selected, opts)
        -- Put the last query to register
        local query = fzf.get_last_query()
        if (query ~= '') then
          -- TODO: Escape for vimregex
          vim.fn.setreg(my_search.search_register, query)
        end

        actions.file_sel_to_qf(selected, opts)
      end,
    }),
  },
}

--------------------------------------------------------------------------------
-- Mappings
--------------------------------------------------------------------------------
local map = vim.keymap.set

map('n', '<Leader><Leader>', fzf.git_files, { desc = 'Git files' })
map('n', '<Leader>,', fzf.files, { desc = 'All files' })
map('n', '<Leader>.', find_sibling_files, { desc = 'Sibling files' })
map('n', '<Leader>bb', fzf.buffers, { desc = 'Buffer list' })
map('n', '<Leader>fp', find_nvim_config_files, { desc = 'NVIM config files' })
map('n', '<Leader>fP', find_config_files, { desc = 'Dot config files' })

map('n', '<Leader>sp', fzf.live_grep, { desc = 'Live grep' })
map('x', '<Leader>sp', fzf.grep_visual, { desc = 'Grep selection' })
map('n', '<Leader>sb', fzf.grep_curbuf, { desc = 'Search in current buffer' })

map('n', '<Leader>ht', fzf.colorschemes, { desc = 'Color schemes' })
map('n', '<Leader>hh', fzf.help_tags, { desc = 'VIM help' })
map('n', '<Leader>:', fzf.commands, { desc = 'Commands list' })
map('n', '<Leader>;', fzf.commands, { desc = 'Commands list' })
