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

vim.cmd [[autocmd BufWritePost plugins.lua PackerCompile]] -- Auto compile!

require('packer').startup {
	function()
		use 'wbthomason/packer.nvim'

		-- Lua essentials
		use 'tjdevries/astronauta.nvim'

		-- Finders
		use {
			'junegunn/fzf.vim',
			requires = {
				'junegunn/fzf',
				run = function() vim.fn['fzf#install'](0) end
			}
		}
		use {
			'nvim-telescope/telescope.nvim',
			requires = {
				'nvim-lua/popup.nvim',
				'nvim-lua/plenary.nvim',
			}
		}
		use 'nvim-telescope/telescope-fzy-native.nvim'
		use 'kevinhwang91/nvim-bqf'

		-- Editors
		use 'tpope/vim-surround'
		use {
			'phaazon/hop.nvim',
			config = function()
				vim.cmd[[ source $HOME/.config/nvim/packages/hop.vim ]]
			end,
		}
		use 'tpope/vim-commentary'
		use {
			'neoclide/coc.nvim',
			branch = 'release',
			ft = {
				'javascript', 'javascriptreact', 'typescript', 'typescriptreact', 'css',
				'json', 'php',
				'purescript', 'haskell',
			},
			config = function()
				vim.cmd[[ source $HOME/.config/nvim/packages/coc.vim ]]
			end
		}

		use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
		use 'p00f/nvim-ts-rainbow'

		-- Themes & Apperances
		use {
			'kyazdani42/nvim-web-devicons',
			config = function()
				require('nvim-web-devicons').setup { default = true }
			end
		}
		use { 'npxbr/gruvbox.nvim', requires = { 'rktjmp/lush.nvim' }, disable = true }
		use 'lifepillar/vim-gruvbox8'
		use 'drewtempelmeyer/palenight.vim'
		use 'sainnhe/gruvbox-material'
		use 'franbach/miramare'
		use { 'embark-theme/vim', as = 'embark' }
		use { 'kaicataldo/material.vim', branch = 'main' }
		use { 'challenger-deep-theme/vim', as = 'challenger-deep' }

		use 'itchyny/lightline.vim'
		use {
			'norcalli/nvim-colorizer.lua',
			config = function() require('colorizer').setup() end
		}
		use 'mhinz/vim-startify'
		use 'TaDaa/vimade'
		use {
			'airblade/vim-gitgutter',
			config = function()
				vim.cmd[[ source $HOME/.config/nvim/packages/gitgutter.vim ]]
			end,
		}
		use 'thaerkh/vim-indentguides'
		-- use { 'lukas-reineke/indent-blankline.nvim', branch = 'lua' }

		-- Languages
		-- use 'sheerun/vim-polyglot'

		-- etc
		use { 'wakatime/vim-wakatime', event = {'BufReadPost'} }
		use 'airblade/vim-rooter'
		use {
			'voldikss/vim-floaterm',
			config = function()
				vim.cmd[[ source $HOME/.config/nvim/packages/floaterm.vim ]]
			end,
		}
		use 'f-person/git-blame.nvim'
		use 'tweekmonster/startuptime.vim'
	end
}
