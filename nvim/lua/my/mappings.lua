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

map({ 'n', 'i', 'v', 'x', 'o' }, '<Up>', 'gk')
map({ 'n', 'i', 'v', 'x', 'o' }, '<Down>', 'gj')

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
map('n', '<Leader>yp', ':let @+=@% <CR>', { desc = "Copy current file's absolute path"})

-- Pasting
map('x', 'p', '"_dhp', { desc = 'Replace selection on paste' })
map('n', 'p', 'p`[v`]=', { desc = 'Paste (below) then auto indent' })
map('n', 'P', 'P`[v`]=', { desc = 'Paste (above) then auto indent' })

-- Code
map('n', '<Leader>cts', ':%s/\t/<space><space>/g<CR>', { desc = 'Tab -> Space' })
map('n', '<Leader>cst', ':%s/<space><space>/\t/g<CR>', { desc = 'Space -> Tab' })
map('n', '<Leader>cl', 'f<Space>xi<CR><Esc>', { desc = 'Break line on space' })

-- Git
map('n', '<Leader>gd', ':DiffviewOpen<CR>', { desc = 'Open diff view' })
map('n', '<Leader>gg', ':FloatermNew lazygit<CR>', { desc = 'Open Lazygit' })

-- Config
map('n', '<Leader>hrr', ':execute "luafile $HOME/.config/nvim/init.lua" | PackerCompile<CR>', { desc = 'Reload config' })

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
