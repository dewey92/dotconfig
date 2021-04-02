local utils = require('my.utils')

require('gitsigns').setup {
  signs = {
    add          = {hl = 'MyGitSignsAdd'   , text = '│+', numhl='GitSignsAddNr'   , linehl='GitSignsAddLn'},
    change       = {hl = 'MyGitSignsChange', text = '│~', numhl='GitSignsChangeNr', linehl='GitSignsChangeLn'},
    delete       = {hl = 'MyGitSignsDelete', text = '│_', numhl='GitSignsDeleteNr', linehl='GitSignsDeleteLn'},
    topdelete    = {hl = 'MyGitSignsDelete', text = '│—', numhl='GitSignsDeleteNr', linehl='GitSignsDeleteLn'},
    changedelete = {hl = 'MyGitSignsChange', text = '│~', numhl='GitSignsChangeNr', linehl='GitSignsChangeLn'},
  },
  keymaps = {
    noremap = true,
    buffer = true,
    silent = true,

    ['n ]h'] = { expr = true, "&diff ? ']h' : '<cmd>lua require\"gitsigns\".next_hunk()<CR>'"},
    ['n [h'] = { expr = true, "&diff ? '[h' : '<cmd>lua require\"gitsigns\".prev_hunk()<CR>'"},

    ['n <leader>gs'] = '<cmd>lua require"gitsigns".stage_hunk()<CR>',
    ['n <leader>gS'] = '<cmd>lua require"gitsigns".undo_stage_hunk()<CR>',
    ['n <leader>gu'] = '<cmd>lua require"gitsigns".reset_hunk()<CR>',
    ['n <leader>gp'] = '<cmd>lua require"gitsigns".preview_hunk()<CR>',

    -- Text objects
    ['o ih'] = ':<C-U>lua require"gitsigns".text_object()<CR>',
    ['x ih'] = ':<C-U>lua require"gitsigns".text_object()<CR>'
  },
  watch_index = {
    interval = 1000
  },
  sign_priority = 6,
  update_debounce = 100,
}

local modes = {'Add', 'Change', 'Delete'}

for _, mode in pairs(modes) do
  local fg = utils.get_hlgroup_attr('Diff'..mode, 'foreground')
  local bg = utils.get_hlgroup_attr('SignColumn', 'background')

  vim.cmd(string.format('hi MyGitSigns%s guifg=%s guibg=%s', mode, fg, bg))
end

