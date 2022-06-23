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
  function (use)
    ------------------------------------------------------------------------------
    -- LUA ESSENTIALS
    ------------------------------------------------------------------------------
    use 'wbthomason/packer.nvim'

    ------------------------------------------------------------------------------
    -- FINDERS
    ------------------------------------------------------------------------------
    --[[ use {
      {
        'nvim-telescope/telescope.nvim',
        requires = {
          'nvim-lua/popup.nvim',
          'nvim-lua/plenary.nvim',
        },
        config = function () require('plugins.telescope') end,
        disable = true,
      },
      'nvim-telescope/telescope-fzy-native.nvim'
    } ]]
    use {
      'ibhagwan/fzf-lua',
      requires = {
        'vijaymarupudi/nvim-fzf',
        'kyazdani42/nvim-web-devicons'
      },
      config = function () require('plugins.fzf') end,
    }
    use { 'kevinhwang91/nvim-bqf', ft = 'qf' }

    ------------------------------------------------------------------------------
    -- EDITORS
    ------------------------------------------------------------------------------
    use { 'tpope/vim-surround', event = {'BufReadPost'} }
    use { 'tpope/vim-abolish' }
    use {
      'windwp/nvim-autopairs',
      event = {'BufReadPost'},
      config = function () require('nvim-autopairs').setup() end,
    }
    use {
      'phaazon/hop.nvim',
      config = function ()
        require('hop').setup()
        vim.cmd[[ source $HOME/.config/nvim/packages/hop.vim ]]
      end,
    }
    use {
      'numToStr/Comment.nvim',
      config = function ()
        require('Comment').setup({
          -- @see: https://github.com/JoosepAlviste/nvim-ts-context-commentstring#commentnvim
          pre_hook = function(ctx)
            local U = require 'Comment.utils'

            local location = nil
            if ctx.ctype == U.ctype.block then
              location = require('ts_context_commentstring.utils').get_cursor_location()
            elseif ctx.cmotion == U.cmotion.v or ctx.cmotion == U.cmotion.V then
              location = require('ts_context_commentstring.utils').get_visual_start_location()
            end

            return require('ts_context_commentstring.internal').calculate_commentstring {
              key = ctx.ctype == U.ctype.line and '__default' or '__multiline',
              location = location,
            }
          end,
        })
      end
    }
    use {
      'hrsh7th/nvim-cmp',
      requires = {
        'hrsh7th/vim-vsnip',
        'hrsh7th/cmp-nvim-lsp',
        'hrsh7th/cmp-nvim-lua',
        'hrsh7th/cmp-vsnip',
        'hrsh7th/cmp-path',
        'hrsh7th/cmp-buffer',
      },
      config = function () require('plugins.cmp') end,
    }
    use 'tversteeg/registers.nvim'

    ------------------------------------------------------------------------------
    -- THEMES & APPEARANCES
    ------------------------------------------------------------------------------
    use {
      'kyazdani42/nvim-web-devicons',
      config = function () require('nvim-web-devicons').setup { default = true } end,
    }
    use {
      { 'npxbr/gruvbox.nvim', requires = { 'rktjmp/lush.nvim' }, disable = true },
      { 'lifepillar/vim-gruvbox8', opt = true },
      { 'sainnhe/gruvbox-material', opt = true },
      { 'drewtempelmeyer/palenight.vim', opt = true },
      { 'franbach/miramare', opt = true },
      { 'embark-theme/vim', as = 'embark', opt = true },
      -- { 'marko-cerovac/material.nvim', requires = { 'tjdevries/colorbuddy.nvim' }, opt = true },
      { 'challenger-deep-theme/vim', as = 'challenger-deep', opt = true },
      { 'bluz71/vim-moonfly-colors', opt = true },
      { 'folke/tokyonight.nvim', opt = true },
      { 'EdenEast/nightfox.nvim', opt = true },
      { 'RRethy/nvim-base16', opt = true },
    }

    use 'itchyny/lightline.vim'
    use {
      'norcalli/nvim-colorizer.lua',
      config = function () require('colorizer').setup() end,
    }
    use {
      'mhinz/vim-startify',
      config = function() vim.g.startify_change_to_dir = 0 end,
    }
    use {
      'TaDaa/vimade',
      config = function ()
        vim.g.vimade = {
          enabletreesitter = 1
        }
      end
    }
    -- use 'thaerkh/vim-indentguides'
    use {
      'lukas-reineke/indent-blankline.nvim',
      config = function ()
        require('indent_blankline').setup {
          show_current_context = true,
          show_current_context_start = true,
          show_first_indent_level = false,
          use_treesitter = true,
        }
      end,
    }
    use {
      'karb94/neoscroll.nvim',
      config = function () require('neoscroll').setup() end,
    }
    use {
      'folke/zen-mode.nvim',
      config = function()
        require('zen-mode').setup {
          plugins = {
            kitty = {
              enabled = true,
              font = '+3',
            }
          }
        }
      end
    }

    ------------------------------------------------------------------------------
    -- LANGUAGES
    ------------------------------------------------------------------------------
    use {
      {
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate',
        config = function () require('plugins.treesitter') end,
      },
      'nvim-treesitter/nvim-treesitter-textobjects',
      'nvim-treesitter/playground',
      'p00f/nvim-ts-rainbow',
      'windwp/nvim-ts-autotag',
      'JoosepAlviste/nvim-ts-context-commentstring',
      'jose-elias-alvarez/nvim-lsp-ts-utils',
    }

    use 'purescript-contrib/purescript-vim'
    use 'vmchale/dhall-vim'
    use "b0o/schemastore.nvim"

    use {
      {
        'neovim/nvim-lspconfig',
        config = function () require('plugins.lsp') end,
      },
      'onsails/lspkind-nvim',
      'ray-x/lsp_signature.nvim',
    }

    use {
      'folke/trouble.nvim',
      requires = 'kyazdani42/nvim-web-devicons',
      config = function() require('trouble').setup() end,
    }

    ------------------------------------------------------------------------------
    -- Git
    ------------------------------------------------------------------------------
    use {
      'lewis6991/gitsigns.nvim',
      requires = { 'nvim-lua/plenary.nvim' },
      config = function () require('plugins.gitsigns') end,
    }
    use {
      'f-person/git-blame.nvim',
      config = function ()
        vim.g.gitblame_message_template = '<committer>, <committer-date> • <summary> • <sha>'
        vim.g.gitblame_date_format = '%d %b %Y'
      end
    }
    use {
      'sindrets/diffview.nvim',
      requires = { 'kyazdani42/nvim-web-devicons' },
      config = function () require('diffview').setup {} end,
    }

    ------------------------------------------------------------------------------
    -- ETC
    ------------------------------------------------------------------------------
    use { 'wakatime/vim-wakatime', event = {'BufReadPost'} }
    use {
      'airblade/vim-rooter',
      config = function () vim.g.rooter_patterns = {'.git'} end,
    }
    use {
      'voldikss/vim-floaterm',
      config = function () vim.cmd[[ source $HOME/.config/nvim/packages/floaterm.vim ]] end,
    }
    use 'tweekmonster/startuptime.vim'
  end,
  config = {
    display = {
      open_fn = require('packer.util').float
    }
  }
}
