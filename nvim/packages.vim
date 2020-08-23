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

" Completions
Plug 'neoclide/coc.nvim', { 'branch': 'release' }
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-commentary'

" Themes & Apperances
Plug 'drewtempelmeyer/palenight.vim'
" Plug 'chuling/ci_dark'
Plug 'itchyny/lightline.vim'
Plug 'mhinz/vim-startify'
Plug 'itchyny/vim-gitbranch'
Plug 'TaDaa/vimade'
Plug 'luochen1990/rainbow'

" Languages
Plug 'pangloss/vim-javascript'
Plug 'leafgarland/typescript-vim'
Plug 'peitalin/vim-jsx-typescript'
Plug 'styled-components/vim-styled-components', { 'branch': 'main' }

" etc
Plug 'kevinhwang91/rnvimr'
Plug 'wakatime/vim-wakatime'
Plug 'airblade/vim-rooter'

call plug#end()
