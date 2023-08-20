local flash = require('flash')
flash.setup({
  search = {
    multi_window = false,
  },
  label = {
    uppercase = false,
  },
  modes = {
    char = {
      jump_labels = true
    },
    treesitter_search = {
      search = {
        multi_window = false,
      },
    },
  },
})

local map = vim.keymap.set

map({'n','x','o'}, 's', flash.jump, { remap = true })
map({'n','x','o'}, 'S', flash.treesitter, { remap = true })
map({'x','o'}, 'R', flash.treesitter_search, { remap = true })
