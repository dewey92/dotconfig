local utils = require('my.utils')

require('gitsigns').setup {
  signs = {
    add          = { hl = 'MyGitSignsAdd'   , text = '│' },
    change       = { hl = 'MyGitSignsChange', text = '│' },
    delete       = { hl = 'MyGitSignsDelete', text = '│' },
    topdelete    = { hl = 'MyGitSignsDelete', text = '│' },
    changedelete = { hl = 'MyGitSignsDelete', text = '│' },
  },
  current_line_blame = true,
  current_line_blame_formatter = '<author>, <author_time:%d %b %Y> • <summary> • <abbrev_sha>',
  on_attach = function(bufnr)
    local gs = package.loaded.gitsigns

    local function map(mode, l, r, opts)
      opts = opts or {}
      opts.buffer = bufnr
      vim.keymap.set(mode, l, r, opts)
    end

    -- Navigation
    map('n', ']h', function()
      if vim.wo.diff then return ']h' end
      vim.schedule(function() gs.next_hunk() end)
      return '<Ignore>'
    end, { expr = true })

    map('n', '[h', function()
      if vim.wo.diff then return '[h' end
      vim.schedule(function() gs.prev_hunk() end)
      return '<Ignore>'
    end, { expr = true })

    -- Actions
    map('n', '<leader>gb', ':Gitsigns blame_line<CR>', { desc = 'Blame line' })
    map({ 'n', 'v' }, '<leader>gs', ':Gitsigns stage_hunk<CR>', { desc = 'Stage hunk' })
    map({ 'n', 'v' }, '<leader>gu', ':Gitsigns reset_hunk<CR>', { desc = 'Reset hunk' })
    map('n', '<leader>gS', gs.undo_stage_hunk, { desc = 'Undo stage hunk' })
    -- map('n', '<leader>hS', gs.stage_buffer)
    -- map('n', '<leader>hR', gs.reset_buffer)
    map('n', '<leader>gp', gs.preview_hunk, { desc = 'Diff preview hunk' })

    -- Text object
    map({'o', 'x'}, 'ih', ':<C-U>Gitsigns select_hunk<CR>')
  end,
  watch_gitdir = {
    interval = 1000
  },
  sign_priority = 6,
  update_debounce = 100,
}

local modes = {
  Add = '#b8bb26',
  Change = '#fabd2f',
  Delete = '#fb4934',
}

local function git_signs_color ()
  for mode, color in pairs(modes) do
    local fg = color
    local bg = utils.get_hlgroup_attr('SignColumn', 'background')

    vim.cmd(string.format('hi MyGitSigns%s guifg=%s guibg=%s', mode, fg, bg))
  end
end

git_signs_color()
