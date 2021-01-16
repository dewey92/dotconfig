if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  "autocmd VimEnter * PlugInstall
  autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

call plug#begin('~/.config/nvim/autoload/plugged')

" Finders
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" Editors
Plug 'tpope/vim-surround'
Plug 'easymotion/vim-easymotion'
Plug 'tpope/vim-commentary'
Plug 'neoclide/coc.nvim', { 'branch': 'release' }

" Themes & Apperances
Plug 'drewtempelmeyer/palenight.vim'
Plug 'gruvbox-community/gruvbox'
Plug 'sainnhe/gruvbox-material'
Plug 'franbach/miramare'
Plug 'kaicataldo/material.vim', { 'branch': 'main' }
Plug 'itchyny/lightline.vim'
Plug 'mhinz/vim-startify'
Plug 'itchyny/vim-gitbranch'
Plug 'TaDaa/vimade'
Plug 'luochen1990/rainbow'
Plug 'airblade/vim-gitgutter'

" Languages
Plug 'pangloss/vim-javascript'
Plug 'leafgarland/typescript-vim'
Plug 'peitalin/vim-jsx-typescript'
Plug 'styled-components/vim-styled-components', { 'branch': 'main' }
Plug 'purescript-contrib/purescript-vim'
Plug 'plasticboy/vim-markdown'

" etc
Plug 'wakatime/vim-wakatime'
Plug 'airblade/vim-rooter'
Plug 'voldikss/vim-floaterm'
" Plug 'vimwiki/vimwiki'

call plug#end()
