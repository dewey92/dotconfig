local M = {}

local actions = require('telescope.actions')
local builtin = require('telescope.builtin')
local pickers = require('telescope.pickers')
local finders = require('telescope.finders')
local sorters = require('telescope.sorters')
local action_state = require('telescope.actions.state')

local utils = require('my.utils')

require('telescope').setup {
  defaults = {
    vimgrep_arguments = {
      'rg',
      '--color=never',
      '--no-heading',
      '--with-filename',
      '--hidden',
      '--line-number',
      '--column',
      '--smart-case'
    },
    prompt_prefix = '  λ ',
    selection_caret = '» ',
    entry_prefix = '  ',
    initial_mode = 'insert',
    selection_strategy = 'reset',
    sorting_strategy = 'ascending',
    layout_strategy = 'flex',
    layout_config = {
      horizontal = {
        -- width_padding  = 0.18,
        -- height_padding = 0.18,
        preview_width  = 0.6,
      },
      vertical = {
        -- width_padding  = 0.05,
        -- height_padding = 1,
        preview_height = 0.5,
      },
      prompt_position = 'top',
      preview_cutoff = 200,
    },
    file_sorter = sorters.get_fzy_sorter,
    file_ignore_patterns = { 'node_modules' },
    generic_sorter = sorters.get_generic_fuzzy_sorter,
    -- path_display = true,
    winblend = 10,
    use_less = true,
    set_env = { ['COLORTERM'] = 'truecolor' }, -- default = nil,
    mappings = {
      i = {
        ["<TAB>"] = actions.toggle_selection,
        ["<C-j>"] = actions.move_selection_next,
        ["<C-k>"] = actions.move_selection_previous,
      },
      n = {
        ["<TAB>"] = actions.toggle_selection,
        ["<C-c>"] = actions.close,
      }
    }
  },
  extensions = {
    fzy_native = {
      override_generic_sorter = false,
      override_file_sorter = true,
    }
  }
}
require('telescope').load_extension('fzy_native')

M.nvim_config = function()
  builtin.find_files {
    cwd = '~/.config/nvim',
    prompt_title = 'NVIM Config',
  }
end

M.find_sibling_files = function()
  builtin.find_files {
    cwd = vim.fn.expand('%:p:h'),
    prompt_title = 'Sibling Files',
  }
end

M.search_string = function(text)
  builtin.grep_string {
    path_display = true,
    word_match = "-w",
    only_sort_text = true,
    search = text or ''
  }
end

-- FIXME: putting selected text into register doesn't work
M.visual_search_string = function()
  M.search_string(utils.get_visual_selection())
end

M.run_command = function(opts)
  local commands = opts.commands or {}
  local texts = {}
  for _, pair in pairs(commands) do
    table.insert(texts, pair.text)
  end

  local function run_command(prompt_bufnr)
    local entry = action_state.get_selected_entry(prompt_bufnr)
    actions.close(prompt_bufnr)

    for _, pair in pairs(commands) do
      if (pair.text == entry.value) then
        vim.cmd(pair.command)
        return
      end
    end
  end

  pickers.new(opts, {
    prompt_title = 'Actions',
    finder = finders.new_table({ results = texts }),
    sorter = sorters.get_generic_fuzzy_sorter(opts),
    attach_mappings = function(_, map)
      map('i', '<CR>', run_command)

      return true
    end,
    layout_strategy = 'center',
    layout_config = {
      height = 0.4,
      width = 0.4,
    },
  }):find()
end

--------------------------------------------------------------------------------
-- Highlighting
--------------------------------------------------------------------------------
vim.cmd[[
  hi! TelescopeBorder         guifg=#596580
  hi! TelescopePromptBorder   guifg=#596580
  hi! TelescopeResultsBorder  guifg=#596580
  hi! TelescopePreviewBorder  guifg=#8292b5

  hi! TelescopePromptPrefix   guifg=#fcba03 gui=bold
]]

--------------------------------------------------------------------------------
-- Mappings
--------------------------------------------------------------------------------
local k = require('astronauta.keymap')
local nnoremap = k.nnoremap
local xnoremap = k.xnoremap
local opts = { silent = true }

nnoremap { '<Leader><Leader>', builtin.git_files, opts }
nnoremap { '<Leader>,', builtin.find_files, opts }
nnoremap { '<Leader>.', M.find_sibling_files, opts }
nnoremap { '<Leader>bb', builtin.buffers, opts }
nnoremap { '<Leader>fp', M.nvim_config, opts }

nnoremap { '<Leader>sp', builtin.live_grep, opts }
xnoremap { '<Leader>sp', M.visual_search_string, opts }
nnoremap { '<Leader>sP', M.search_string, opts } -- very slow for large project
nnoremap { '<Leader>sb', builtin.current_buffer_fuzzy_find, opts }

nnoremap { '<Leader>ht', builtin.colorscheme, opts }
nnoremap { '<Leader>hh', builtin.help_tags, opts }
nnoremap { '<Leader>:', builtin.commands, opts }
nnoremap { '<Leader>;', builtin.commands, opts }

return M
