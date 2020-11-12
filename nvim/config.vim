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
" set ruler                               " Show the cursor position all the time
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
set so=5                                " Scroll offset to get a code peak

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

let s:current_theme = 'material'
function! LoadTheme()
  if s:current_theme == 'gruvbox_material'
    let g:gruvbox_material_background = 'hard'
    let g:gruvbox_material_enable_italic = 1
    let g:gruvbox_material_enable_bold = 1
    let g:gruvbox_material_current_word = 'bold'
    let g:gruvbox_material_diagnostic_line_highlight = 1
    let s:lightline_theme = 'gruvbox_material'
  elseif s:current_theme == 'miramare'
    let g:miramare_enable_italic = 1
    let g:miramare_current_word = 'bold'
    let s:lightline_theme = 'miramare'
  elseif s:current_theme == 'material'
    let g:material_theme_style = 'darker-community'
    let g:material_terminal_italics = 1
    let s:lightline_theme = 'material_vim'
  endif
  
  execute 'colorscheme ' . s:current_theme
endfunction
call LoadTheme()

let g:lightline = {
  \ 'colorscheme': s:lightline_theme,
  \ 'active': {
  \   'left': [ ['mode'], ['readonly', 'relativepath', 'modified'] ],
  \   'right': [ ['lineinfo'], ['percent'], ['filetype'], ['cocstatus'] ]
  \ },
  \ 'component_function': {
  \   'gitbranch': 'gitbranch#name',
  \   'cocstatus': 'coc#status',
  \ },
  \ }

" Purescript
let g:purescript_indent_do = 2
let g:purescript_indent_where = 2
let g:purescript_indent_case = 2
let g:purescript_indent_in = 0

" Use auocmd to force lightline update.
autocmd User CocStatusChange,CocDiagnosticChange call lightline#update()

" Automatically rebalance windows on vim resize
autocmd VimResized * :wincmd =

" Use space for these filetypes
autocmd FileType purescript set expandtab shiftwidth=2 softtabstop=2 tabstop=2
