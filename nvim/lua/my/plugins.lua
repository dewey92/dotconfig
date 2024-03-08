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
    use {
      'kevinhwang91/nvim-bqf',
      ft = 'qf',
      config = function ()
        require('bqf').setup {
          auto_resize_height = true,
        }
      end,
    }

    ------------------------------------------------------------------------------
    -- EDITORS
    ------------------------------------------------------------------------------
    use {
      'kylechui/nvim-surround',
      event = {'BufReadPost'},
      config = function()
        require('nvim-surround').setup { }
      end
    }
    use { 'tpope/vim-abolish' }
    use {
      'windwp/nvim-autopairs',
      event = {'BufReadPost'},
      config = function () require('nvim-autopairs').setup() end,
    }
    use {
      'folke/flash.nvim',
      config = function () require('plugins.flash') end,
    }
    use {
      'numToStr/Comment.nvim',
      config = function ()
        require('Comment').setup({
          context_commentstring = {
            enable = true,
            enable_autocmd = false,
          },
          -- @see: https://github.com/JoosepAlviste/nvim-ts-context-commentstring/wiki/Integrations#commentnvim
          pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook(),
        })
      end
    }
    use {
      'L3MON4D3/LuaSnip',
      requires = { 'rafamadriz/friendly-snippets' },
      config = function ()
        require('luasnip.loaders.from_vscode').lazy_load()

        local ls = require('luasnip')
        local map = vim.keymap.set
        map({'i', 's'}, '<C-l>', function ()
          if ls.jumpable(1) then
            ls.jump(1)
          end
        end)
        map({'i', 's'}, '<C-h>', function ()
          if ls.jumpable(-1) then
            ls.jump(-1)
          end
        end)
      end,
    }
    use {
      'hrsh7th/nvim-cmp',
      requires = {
        'hrsh7th/cmp-nvim-lsp',
        'hrsh7th/cmp-nvim-lua',
        'hrsh7th/cmp-path',
        'hrsh7th/cmp-buffer',
        'saadparwaiz1/cmp_luasnip',
      },
      config = function () require('plugins.cmp') end,
    }
    use 'tversteeg/registers.nvim'
    use {
      'gbprod/yanky.nvim',
      config = function() require('yanky').setup {} end
    }

    ------------------------------------------------------------------------------
    -- THEMES & APPEARANCES
    ------------------------------------------------------------------------------
    use {
      'kyazdani42/nvim-web-devicons',
      config = function () require('nvim-web-devicons').setup { default = true } end,
    }
    use {
      { 'lifepillar/vim-gruvbox8', opt = true },
      { 'catppuccin/nvim', as = 'catppuccin', opt = true },
    }

    use 'itchyny/lightline.vim'
    use {
      'norcalli/nvim-colorizer.lua',
      config = function () require('colorizer').setup() end,
    }
    use {
      'goolord/alpha-nvim',
      requires = { 'nvim-tree/nvim-web-devicons' },
      config = function ()
        local startify = require('alpha.themes.startify').config
        startify.opts.keymap = {
          press = '<CR>',
          queue_press = { 'v', '<Space>' },
        }

        require('alpha').setup(startify)
      end
    }
    use {
      'TaDaa/vimade',
      config = function ()
        vim.g.vimade = {
          enabletreesitter = 1,
          fadelevel = .6,
        }
      end
    }
    -- use 'thaerkh/vim-indentguides'
    use {
      'lukas-reineke/indent-blankline.nvim',
      config = function ()
        require('ibl').setup {
          indent = {
            char = ' ', -- hide to look cleaner
            tab_char = '│', -- only show the indent guide for context
          },
        }
      end,
    }
    use {
      'karb94/neoscroll.nvim',
      config = function () require('neoscroll').setup({ easing_function = 'cubic' }) end,
    }
    use {
      'folke/zen-mode.nvim',
      disable = true,
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

    use {
      'rcarriga/nvim-notify',
      config = function ()
        require('notify').setup {
          background_colour = '#000000'
        }

        vim.notify = require('notify')
      end
    }
    use {
      'folke/which-key.nvim',
      config = function() require('which-key').setup {} end
    }
    --[[ use {
      'anuvyklack/pretty-fold.nvim',
      config = function()
        require('pretty-fold').setup {
          matchup_patterns = {
            { '^import', '^$' }
          }
        }
      end
    } ]]

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
      'HiPhish/rainbow-delimiters.nvim',
      config = function ()
        require 'rainbow-delimiters.setup' {
          query = {
            [''] = 'rainbow-delimiters',
            lua = 'rainbow-blocks',
            javascript = 'rainbow-delimiters-react',
          }
        }
      end
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
      'sindrets/diffview.nvim',
      requires = { 'kyazdani42/nvim-web-devicons' },
      config = function ()
        local actions = require('diffview.actions')

        require('diffview').setup {
          keymaps = {
            view = {
              ['<Leader>gd'] = actions.close,
            },
            file_panel = {
              ['<Leader>gd'] = actions.close,
            },
            file_history_panel = {
              ['<Leader>gd'] = actions.close,
            },
            option_panel = {
              ['<Leader>gd'] = actions.close,
            },
          }
        }
      end,
    }
    use {
      'akinsho/git-conflict.nvim',
      config = function ()
        require('git-conflict').setup({
          default_mappings = false,
        })
      end,
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
      config = function () vim.cmd[[ source $HOME/.config/nvim/vimscript/floaterm.vim ]] end,
    }
    use 'tweekmonster/startuptime.vim'
    use {
      'james1236/backseat.nvim',
      config = function()
        require('backseat').setup({
          -- openai_model_id = 'gpt-3.5-turbo',
          openai_model_id = 'gpt-4', --gpt-4 (If you do not have access to a model, it says "The model does not exist")
          additional_instruction = "You're a very senior developer, respond snarkily with concrete suggestions",
          highlight = {
            group = 'DiagnosticVirtualTextInfo',
          },
        })
      end
    }
    use {
      'glacambre/firenvim',
      run = function() vim.fn['firenvim#install'](0) end,
      disable = true,
    }
  end,

  config = {
    display = {
      open_fn = require('packer.util').float
    }
  }
}
