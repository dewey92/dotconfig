" General {{{
" _______
let g:mapleader = "\<Space>"

syntax enable                           " Enables syntax highlighing
set hidden                              " Required to keep multiple buffers open multiple buffers
set nowrap                              " Display long lines as just one line
set encoding=utf-8                      " The encoding displayed
set pumheight=10                        " Makes popup menu smaller
set fileencoding=utf-8                  " The encoding written to file
set number                              " Line numbers
set ruler                               " Show the cursor position all the time
set cmdheight=1                         " More space for displaying messages
set mouse=a                             " Enable your mouse
set splitbelow                          " Horizontal splits will automatically be below
set splitright                          " Vertical splits will automatically be to the right
set conceallevel=0                      " So that I can see `` in markdown files
set smartindent                         " Makes indenting smart
set autoindent                          " Good auto indent
set updatetime=300                      " Faster completion
set timeoutlen=500                      " By default timeoutlen is 1000 ms
set formatoptions-=cro                  " Stop newline continution of comments
set clipboard=unnamedplus               " Copy paste between vim and everything else
" set autochdir                           " Your working directory will always be the same as your working directory

" }}}
" Tabs & Spaces
" _____________ {{{
set showtabline=0                       " Don't show tab line! We have filename already yielded below
set tabstop=2                           " Insert 2 spaces for a tab
set shiftwidth=2                        " Change the number of space characters inserted for indentation
set smarttab                            " Makes tabbing smarter will realize you have 2 vs 4
" set expandtab                           " Converts tabs to spaces
set list
set listchars=tab:▸\ ,extends:❯,precedes:❮ 

" }}}
" Themes & Appearances {{{
" ____________________
set cursorline                          " Enable highlighting of the current line
set background=dark                     " tell vim what the background color looks like
set t_Co=256                            " Support 256 colors
set laststatus=2                        " Always display the status line
set noshowmode                          " We don't need to see things like -- INSERT -- anymore

if (has("termguicolors"))
 set termguicolors
endif

let g:rainbow_active = 1

let g:lightline = {
	\ 'colorscheme': 'gruvbox_material',
	\ 'active': {
	\   'right': [ [ 'lineinfo' ],
	\              [ 'percent' ],
	\              [ 'gitbranch', 'filetype' ] ]
	\ },
	\ 'component_function': {
	\   'gitbranch': 'gitbranch#name'
	\ },
	\ }
let g:gruvbox_material_background = 'hard'
let g:gruvbox_material_enable_italic = 1
let g:gruvbox_material_enable_bold = 1
let g:gruvbox_material_current_word = 'bold'
let g:gruvbox_material_diagnostic_line_highlight = 1
colorscheme gruvbox-material

" Automatically rebalance windows on vim resize
autocmd VimResized * :wincmd =
