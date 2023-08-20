local hop = require('hop')
local directions = require('hop.hint').HintDirection

hop.setup()

local map = vim.keymap.set

map({'n','x'}, 's', '<CMD>HopChar2<CR>', { remap = true })
map({'n','x'}, '<Leader>s<space>', '<CMD>HopPattern<CR>', { remap = true })

map({'n','v','x','o'}, 'f', '<CMD>HopChar1CurrentLineAC<CR>', { remap = true })
map({'n','v','x','o'}, 'F', '<CMD>HopChar1CurrentLineBC<CR>', { remap = true })
map({'n','v','x','o'}, 't',
  function () hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = true, hint_offset = -1 }) end,
  { remap = true }
)
map({'n','v','x','o'}, 'T',
  function () hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = true, hint_offset = 1 }) end,
  { remap = true }
)
