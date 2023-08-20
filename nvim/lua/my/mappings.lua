local wk = require('which-key')

wk.register({
  b = { name = 'Buffers' },
  w = { name = 'Windows' },
  f = { name = 'Files' },
  c = { name = 'Code' },
  g = { name = 'Git' },
  t = { name = 'Terminal' },
  h = { name = 'Help' },
  s = { name = 'Search' },
  q = { name = 'Quit' },
}, { prefix = '<Leader>' })

local map = vim.keymap.set

map({ 'n', 'v', 'x', 'o' }, '<Up>', 'gk')
map({ 'n', 'v', 'x', 'o' }, '<Down>', 'gj')

-- Buffers
map('n', '<Leader>bn', ':bnext<CR>', { desc = 'Next buffer' })
map('n', '<Leader>bp', ':bprevious<CR>', { desc = 'Prev buffer' })
map('n', '<Leader>bd', ':bp|bd #<CR>', { desc = 'Delete buffer' })
map('n', '<Leader>bD', ':bp|bd #<CR><C-w>c', { desc = 'Delete buffer + window' })
map('n', '<Leader>br', ':e<CR>', { desc = 'Refresh buffer' })

-- Popup menu
map('i', '<TAB>', 'pumvisible() ? "<C-n>" : "<TAB>"', { expr = true })
map('i', '<C-j>', 'pumvisible() ? "<C-n>" : "<C-j>"', { expr = true })
map('i', '<C-k>', 'pumvisible() ? "<C-n>" : "<C-k>"', { expr = true })

-- Windows
map('n', '<Leader>wh', '<C-w>h', { desc = 'Switch to left' })
map('n', '<Leader>wj', '<C-w>j', { desc = 'Switch to bottom '})
map('n', '<Leader>wk', '<C-w>k', { desc = 'Switch to top' })
map('n', '<Leader>wl', '<C-w>l', { desc = 'Switch to right' })
map('n', '<A-h>', '<C-w>h', { desc = 'Switch to left' })
map('n', '<A-j>', '<C-w>j', { desc = 'Switch to bottom '})
map('n', '<A-k>', '<C-w>k', { desc = 'Switch to top' })
map('n', '<A-l>', '<C-w>l', { desc = 'Switch to right' })
map('n', '<Leader>wH', '<C-w>H', { desc = 'Move to the most left' })
map('n', '<Leader>wJ', '<C-w>J', { desc = 'Move to the most bottom' })
map('n', '<Leader>wK', '<C-w>K', { desc = 'Move to the most top' })
map('n', '<Leader>wL', '<C-w>L', { desc = 'Move to the most right' })
map('n', '<Leader>wv', '<C-w>v', { desc = 'Split vertically' })
map('n', '<Leader>ws', '<C-w>s', { desc = 'Split horizontally' })
map('n', '<Leader>wd', '<C-w>c', { desc = 'Close' })

-- Yanking (copying)
map({ 'n', 'x' }, 'y', '<Plug>(YankyYank)')
map('n', '<Leader>yp', ':let @+=@% <CR>', { desc = "Copy current file's absolute path"})

-- Pasting
map('x', 'p', '"_dhp', { desc = 'Replace selection on paste' })
map('n', 'p', 'p`[v`]=', { desc = 'Paste (after) then auto indent' })
map('n', 'P', 'P`[v`]=', { desc = 'Paste (below) then auto indent' })
-- map({'n','x'}, 'p', '<Plug>(YankyPutAfterFilter)', { desc = '' })
-- map({'n','x'}, 'P', '<Plug>(YankyPutBeforeFilter)', { desc = 'Paste (above) then auto indent' })
-- map({'n','x'}, 'gp', '<Plug>(YankyGPutAfter)')
-- map({'n','x'}, 'gP', '<Plug>(YankyGPutBefore)')
map('n', '<C-n>', '<Plug>(YankyCycleForward)')
map('n', '<C-p>', '<Plug>(YankyCycleBackward)')

-- Code
map('n', '<Leader>cts', ':%s/\t/<space><space>/g<CR>', { desc = 'Tab -> Space' })
map('n', '<Leader>cst', ':%s/<space><space>/\t/g<CR>', { desc = 'Space -> Tab' })
map('n', '<Leader>cl', 'f<Space>xi<CR><Esc>', { desc = 'Break line on space' })

-- Git
map('n', '<Leader>gd', ':DiffviewOpen<CR>', { desc = 'Open diff view' })
map('n', '<Leader>gg', ':FloatermNew lazygit<CR>', { desc = 'Open Lazygit' })
map('n', '<Leader>gco', '<Plug>(git-conflict-ours)', { desc = 'Choose ours' })
map('n', '<Leader>gct', '<Plug>(git-conflict-theirs)', { desc = 'Choose theirs' })
map('n', '<Leader>gcb', '<Plug>(git-conflict-both)', { desc = 'Choose both' })
map('n', '<Leader>gcn', '<Plug>(git-conflict-none)', { desc = 'Choose none' })
map('n', '[x', '<Plug>(git-conflict-prev-conflict)')
map('n', ']x', '<Plug>(git-conflict-next-conflict)')

-- Config
local function reload_config ()
  -- Invalidate `require` caches
  require('plenary.reload').reload_module('my.')

  -- vim.cmd('PackerCompile')
  vim.cmd('source $HOME/.config/nvim/init.lua')

  vim.notify('Config reloaded!', vim.log.levels.INFO, { render = 'minimal' })
end
map('n', '<Leader>hr', reload_config, { desc = 'Reload config' })

-- Saving
map('n', ';w', ':w')
map('n', '<Leader>e', ':w | :e<CR>', { desc = 'Write and refresh buffer' })

-- Quitting
map('n', ';q', ':q')
map('n', '<Leader>qa', ':qa<CR>', { desc = 'Exit vim' })
map('n', '<Leader>qq', ':mks! $HOME/.config/nvim/sessions/last.vim | qa<CR>', { desc = 'Save session then quit' })
map('n', '<Leader>ql', ':source $HOME/.config/nvim/sessions/last.vim<CR>', { desc = 'Reload last session' })

-- Selection
map('v', '<', '<gv', { desc = 'Keep selection when unindenting' })
map('v', '>', '>gv', { desc = 'Keep selection when indenting' })

-- Line moves
map('n', '<C-k>', ':m .-2<CR>==', { desc = 'Move line up' })
map('n', '<C-j>', ':m .+1<CR>==', { desc = 'Move line down' })
map('x', '<C-k>' , ':m \'<-2<CR>gv=gv', { desc = 'Move selection up' })
map('x', '<C-j>', ':m \'>+1<CR>gv=gv', { desc = 'Move selection down' })

-- Search
vim.cmd[[ source $HOME/.config/nvim/vimscript/search.vim ]]

-- etc
map('n', 'n', 'nzz')
map('n', 'N', 'Nzz')
map('n', '<Esc><Esc>', ':noh<CR>', { silent = true })
map('i', 'jj', '<Esc>')

local au = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup

au('FileType', {
  group = augroup('QfMapping', {}),
  pattern = 'qf',
  callback = function (event)
    map('n', '<C-c>', ':q<CR>', { buffer = event.buf })
  end,
})
