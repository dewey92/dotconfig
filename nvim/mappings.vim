" Buffer
nnoremap <Leader>bn :bnext<CR>
nnoremap <Leader>bp :bprevious<CR>
nnoremap <Leader>bd :bp\|bd #<CR>
nnoremap <Leader>br :e<CR>

" <TAB>: completion.
inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <expr><C-j> pumvisible() ? "\<C-n>" : "\<C-j>"
inoremap <expr><C-k> pumvisible() ? "\<C-p>" : "\<C-k>"

" Better tabbing
vnoremap < <gv
vnoremap > >gv

" Move lines
nnoremap <C-k> :m .-2<CR>==
nnoremap <C-j> :m .+1<CR>==
xnoremap <C-k> :m '<-2<CR>gv=gv
xnoremap <C-j> :m '>+1<CR>gv=gv

" Better window navigation
nnoremap <Leader>wh <C-w>h
nnoremap <Leader>wj <C-w>j
nnoremap <Leader>wk <C-w>k
nnoremap <Leader>wl <C-w>l
nnoremap <A-h> <C-w>h
nnoremap <A-j> <C-w>j
nnoremap <A-k> <C-w>k
nnoremap <A-l> <C-w>l
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
nnoremap <Leader>hrr :execute 'luafile $HOME/.config/nvim/init.lua' \| PackerCompile \| PackerSync<CR>

" Source what's in selection
vnoremap <Leader>gr :<c-u>exec join(getline("'<","'>"),"\n")<CR>

" Tab to space
nnoremap <Leader>cts :%s/\t/<space><space>/g<CR>

" Make a new line after a space
nnoremap <Leader>nl f<Space>xi<CR><Esc>

" Easy save
nnoremap ;w :w

" Save and reload buffer
nnoremap <Leader>e :w\|:e<CR>

" Quitting & Load
nnoremap <Leader>qq :mks! $HOME/.config/nvim/sessions/last.vim\|qa<CR>
nnoremap <Leader>ql :source $HOME/.config/nvim/sessions/last.vim<CR>

nnoremap <silent> <Esc><Esc> :noh<CR>
