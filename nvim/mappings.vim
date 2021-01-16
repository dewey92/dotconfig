" Buffer
nnoremap <Leader>bn :bnext<CR>
nnoremap <Leader>bp :bprevious<CR>
nnoremap <Leader>bd :bp\|bd #<CR>
nnoremap <Leader>br :e<CR>

" <TAB>: completion.
inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"

" Better tabbing
vnoremap < <gv
vnoremap > >gv

" Move lines
nnoremap <C-k> :<C-u>move-2<CR>==
nnoremap <C-j> :<C-u>move+<CR>==
xnoremap <C-k> :move-2<CR>='[gv
xnoremap <C-j> :move'>+<CR>='[gv

" Better window navigation
nnoremap <Leader>wh <C-w>h
nnoremap <Leader>wj <C-w>j
nnoremap <Leader>wk <C-w>k
nnoremap <Leader>wl <C-w>l
nnoremap <Leader>wH <C-w>H
nnoremap <Leader>wJ <C-w>J
nnoremap <Leader>wK <C-w>K
nnoremap <Leader>wL <C-w>L
nnoremap <Leader>wv <C-w>v
nnoremap <Leader>ws <C-w>s
nnoremap <Leader>wc <C-w>c
nnoremap <Leader>wd <C-w>c

nnoremap <Leader>o o<Esc>^Da
nnoremap <Leader>O O<Esc>^Da

" Sane pasting
xnoremap p "_dhp
xnoremap P "_dhP

" Indent automatically after pasting
nnoremap p p`[v`]=
nnoremap P P`[v`]=

" Copy-paste seamlessly between normal buffer & terminal buffer
tnoremap <expr> <M-r> '<C-\><C-N>"'.nr2char(getchar()).'pi'

" Copy filepath to clipboard
nnoremap <Leader>yp :let @+=@% <CR>

" Source config automatically
nnoremap <Leader>hrr :source $HOME/.config/nvim/init.vim \| :PlugInstall<CR>

" Source what's in selection
vnoremap <Leader>gr :<c-u>exec join(getline("'<","'>"),"\n")<CR>

" Quick search and replace
nnoremap <Leader>r :%s///g<Left><Left>
xnoremap <Leader>r :s///g<Left><Left>
autocmd BufReadPost quickfix nnoremap <buffer> <Leader>r :cfdo %s/<C-r>s//g \| update

" Easy save
nnoremap ;w :w

" Quitting & Load
nnoremap <Leader>qq :mks! $HOME/.config/nvim/sessions/last.vim\|qa<CR>
nnoremap <Leader>ql :source $HOME/.config/nvim/sessions/last.vim<CR>

nnoremap <silent> <Esc><Esc> :noh<CR>
