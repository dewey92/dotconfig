" General {{{
" _______
let g:mapleader = "\<Space>"

syntax enable                           " Enables syntax highlighing
set hidden                              " Required to keep multiple buffers open multiple buffers
set nowrap                              " Display long lines as just one line
set encoding=utf-8                      " The encoding displayed
set pumheight=10                        " Makes popup menu smaller
set fileencoding=utf-8                  " The encoding written to file
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
set so=10                               " Scroll offset to get a code peak
set signcolumn=yes                      " Always show to prevent junky visual when a sign pops up (git gutters, errors, etc)

" }}}
" Tabs & Spaces
" _____________ {{{
set showtabline=0                       " Don't show tab line! We have filename already yielded below
set tabstop=2                           " Insert 2 spaces for a tab
set shiftwidth=2                        " Change the number of space characters inserted for indentation
set smarttab                            " Makes tabbing smarter will realize you have 2 vs 4
" set expandtab                           " Converts tabs to spaces
set list
set listchars=extends:❯,precedes:❮ " Diaplay whitespace chars;

" Use space for these filetypes
filetype plugin indent on
autocmd FileType vim setlocal expandtab shiftwidth=2 softtabstop=2 tabstop=2
autocmd FileType purescript setlocal expandtab shiftwidth=2 softtabstop=2 tabstop=2
autocmd FileType haskell setlocal expandtab shiftwidth=2 softtabstop=2 tabstop=2
autocmd FileType markdown setlocal expandtab shiftwidth=2 softtabstop=2 tabstop=2 wrap linebreak

" Guide indentations
let g:indentguides_spacechar = '|'
let g:indentguides_tabchar = '▸'

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

let s:current_theme = 'gruvbox-material'
function! LoadTheme()
  if s:current_theme == 'gruvbox-material'
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

" Use autocmd to force lightline update.
autocmd User CocStatusChange,CocDiagnosticChange call lightline#update()

" Enable hybrid line numbering, only fro the focused buffer
set number relativenumber
augroup numbertoggle
	autocmd!
	autocmd BufEnter,FocusGained,WinEnter * if &nu | set rnu   | endif
	autocmd BufLeave,FocusLost,WinLeave   * if &nu | set nornu | endif
augroup END

" Create whitespace group
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()

" Automatically rebalance windows on vim resize
autocmd VimResized * :wincmd =

" Git blame
let g:blamer_enabled = 1
let g:blamer_template = '<committer>, <committer-time> • <summary> • <commit-short>'
let g:blamer_date_format = '%d/%m/%y'

" }}}
" Languages {{{
" ____________________

" Purescript
let g:purescript_indent_do = 2
let g:purescript_indent_where = 2
let g:purescript_indent_case = 2
let g:purescript_indent_in = 0

" Vim Wiki
" let g:vimwiki_map_prefix = '<Leader>n'
" let g:vimwiki_list = [{
"   \ 'path': '~/vimwiki/',
"   \ 'syntax': 'markdown',
"   \ 'ext' : '.md'
"   \ }]
" let g:vimwiki_ext2syntax = { '.wiki': 'markdown' }

" Markdown
let g:vim_markdown_fenced_languages = [
  \ 'html',
  \ 'javascript',
  \ 'javascriptreact',
  \ 'typescript',
  \ 'ts=typescript',
  \ 'tsx=typescript',
  \ 'bash=sh',
  \ 'haskell',
  \ 'hs=haskell',
  \ ]
