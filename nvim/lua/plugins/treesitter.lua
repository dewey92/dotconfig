require'nvim-treesitter.configs'.setup {
  ensure_installed = 'all',
  highlight = {
    enable = false, -- FIXME: Highlighting still segfault sometimes
  },
  indent = {
    enable = true,
  },
  rainbow = {
    enable = true,
  },
  autotag = {
    enable = true,
  },
  context_commentstring = {
    enable = true
  }
}
