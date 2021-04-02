local packer_exists = pcall(vim.cmd, 'packadd packer.nvim')
if not packer_exists then
  local directory = vim.fn.stdpath('data') .. '/site/pack/packer/start/'
  vim.fn.mkdir(directory, 'p')
  vim.fn.system {
    'git',
    'clone',
    'https://github.com/wbthomason/packer.nvim',
    directory .. '/packer.nvim'
  }
  vim.cmd [[packadd packer.nvim]]
end

vim.cmd [[autocmd BufWritePost plugins.lua execute "luafile $HOME/.config/nvim/lua/my/plugins.lua" | PackerCompile]] -- Auto compile!

require('packer').startup {
  function(use)
    ------------------------------------------------------------------------------
    -- LUA ESSENTIALS
    ------------------------------------------------------------------------------
    use 'wbthomason/packer.nvim'
    use 'tjdevries/astronauta.nvim'

    ------------------------------------------------------------------------------
    -- FINDERS
    ------------------------------------------------------------------------------
    use {
      'junegunn/fzf.vim',
      requires = {
        'junegunn/fzf',
        run = function() vim.fn['fzf#install'](0) end
      },
      disable = true
    }
    use {
      'nvim-telescope/telescope.nvim',
      requires = {
        'nvim-lua/popup.nvim',
        'nvim-lua/plenary.nvim',
      }
    }
    use 'nvim-telescope/telescope-fzy-native.nvim'
    use { 'kevinhwang91/nvim-bqf' }

    ------------------------------------------------------------------------------
    -- EDITORS
    ------------------------------------------------------------------------------
    use { 'tpope/vim-surround', event = {'BufReadPost'} }
    use {
      'windwp/nvim-autopairs',
      event = {'BufReadPost'},
      config = function() require('nvim-autopairs').setup() end,
    }
    use {
      'phaazon/hop.nvim',
      config = function() vim.cmd[[ source $HOME/.config/nvim/packages/hop.vim ]] end,
    }
    use 'tpope/vim-commentary'
    use {
      'hrsh7th/nvim-compe',
      requires = { 'hrsh7th/vim-vsnip' },
      event = {'BufReadPost'},
      config = function() require('plugins.compe') end,
    }

    ------------------------------------------------------------------------------
    -- THEMES & APPEARANCES
    ------------------------------------------------------------------------------
    use {
      'kyazdani42/nvim-web-devicons',
      config = function() require('nvim-web-devicons').setup { default = true } end,
    }
    use {
      { 'npxbr/gruvbox.nvim', requires = { 'rktjmp/lush.nvim' }, disable = true },
      { 'lifepillar/vim-gruvbox8', opt = false },
      { 'sainnhe/gruvbox-material', opt = true },
      { 'drewtempelmeyer/palenight.vim', opt = true },
      { 'franbach/miramare', opt = true },
      { 'embark-theme/vim', as = 'embark', opt = true },
      { 'kaicataldo/material.vim', branch = 'main', opt = true },
      { 'challenger-deep-theme/vim', as = 'challenger-deep', opt = true },
    }

    use 'itchyny/lightline.vim'
    use {
      'norcalli/nvim-colorizer.lua',
      config = function() require('colorizer').setup() end,
    }
    use 'mhinz/vim-startify'
    use 'TaDaa/vimade'
    use 'thaerkh/vim-indentguides'
    -- use { 'lukas-reineke/indent-blankline.nvim', branch = 'lua' }
    use {
      'camspiers/lens.vim',
      requires = { 'camspiers/animate.vim' },
      disable = true, -- It's cool, but messing up with quickfix list. Revisit later
    }
    use 'karb94/neoscroll.nvim'

    ------------------------------------------------------------------------------
    -- LANGUAGES
    ------------------------------------------------------------------------------
    use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
    use 'nvim-treesitter/playground'
    use 'p00f/nvim-ts-rainbow'
    use 'windwp/nvim-ts-autotag'
    use 'JoosepAlviste/nvim-ts-context-commentstring'
    use 'jose-elias-alvarez/nvim-lsp-ts-utils'

    use {
      -- 'neovim/nvim-lspconfig',
      '~/Projects/nvim-lspconfig',
      config = function () require('plugins.lsp') end,
    }
    use 'glepnir/lspsaga.nvim'
    use 'onsails/lspkind-nvim'

    use {
      'neoclide/coc.nvim',
      branch = 'release',
      ft = {
        'javascript', 'javascriptreact', 'typescript', 'typescriptreact', 'css',
        'json', 'php',
        'purescript', 'haskell',
      },
      config = function() vim.cmd[[ source $HOME/.config/nvim/packages/coc.vim ]] end,
      disable = true,
    }

    -- use 'sheerun/vim-polyglot'

    ------------------------------------------------------------------------------
    -- Git
    ------------------------------------------------------------------------------
    use {
      'lewis6991/gitsigns.nvim',
      requires = { 'nvim-lua/plenary.nvim' },
      config = function() require('plugins.gitsigns') end,
    }
    use 'f-person/git-blame.nvim'

    ------------------------------------------------------------------------------
    -- ETC
    ------------------------------------------------------------------------------
    use { 'wakatime/vim-wakatime', event = {'BufReadPost'} }
    use 'airblade/vim-rooter'
    use {
      'voldikss/vim-floaterm',
      config = function() vim.cmd[[ source $HOME/.config/nvim/packages/floaterm.vim ]] end,
    }
    use 'tweekmonster/startuptime.vim'
  end
}
