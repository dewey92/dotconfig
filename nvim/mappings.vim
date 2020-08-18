" Buffer
nnoremap <Leader>bn :bnext<CR>
nnoremap <Leader>bp :bprevious<CR>
nnoremap <Leader>bd :bp\|bd #<CR>

" <TAB>: completion.
inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"

" Better tabbing
vnoremap < <gv
vnoremap > >gv

" Better window navigation
nnoremap <Leader>wh <C-w>h
nnoremap <Leader>wj <C-w>j
nnoremap <Leader>wk <C-w>k
nnoremap <Leader>wl <C-w>l
nnoremap <Leader>wv <C-w>v
nnoremap <Leader>ws <C-w>s
nnoremap <Leader>wc <C-w>c
nnoremap <Leader>wd <C-w>c

nnoremap <Leader>o o<Esc>^Da
nnoremap <Leader>O O<Esc>^Da

" Copy-paste seamlessly between normal buffer & terminal buffer
tnoremap <expr> <M-r> '<C-\><C-N>"'.nr2char(getchar()).'pi'

" Source config automatically
nnoremap <Leader>hrr :source $HOME/.config/nvim/init.vim \| :PlugInstall<CR>

" Source what's in selction
vnoremap <Leader>gr :<c-u>exec join(getline("'<","'>"),"\n")<CR>

" Quitting & Load
nnoremap <Leader>qq :mks! $HOME/.config/nvim/sessions/last.vim\|qa<CR>
nnoremap <Leader>ql :source $HOME/.config/nvim/sessions/last.vim<CR>
