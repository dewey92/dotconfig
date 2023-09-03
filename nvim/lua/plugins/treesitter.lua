require'nvim-treesitter.configs'.setup {
  ensure_installed = {
    'bash',
    'css',
    'diff',
    'dockerfile',
    'html',
    'javascript',
    'json',
    'json5',
    'jsonc',
    'lua',
    'php',
    'toml',
    'tsx',
    'typescript',
    'vim',
    'vimdoc',
    'yaml',
  },
  highlight = {
    enable = true,
    -- disable = {'tsx', 'php'},
    -- additional_vim_regex_highlighting = true,
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
    enable = true,
    -- Following line is to make it work with Comment.nvim
    enable_autocmd = false
  },
  textobjects = {
    select = {
      enable = true,
      -- Automatically jump forward to textobj, similar to targets.vim
      lookahead = true,
      keymaps = {
        -- You can use the capture groups defined in textobjects.scm
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["ac"] = "@class.outer",
        ["ic"] = "@class.inner",
      },
    },
  },
}
