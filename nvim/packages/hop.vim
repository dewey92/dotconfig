nmap <silent> <Leader>ff <CMD>HopChar2<CR>
xmap <silent> <Leader>ff <CMD>HopChar2<CR>

nmap <silent> <Leader>fj <CMD>HopWord<CR>
xmap <silent> <Leader>fj <CMD>HopWord<CR>

nmap <silent> <Leader>f<space> <CMD>HopPattern<CR>
xmap <silent> <Leader>f<space> <CMD>HopPattern<CR>

" Not really Hop specific mapping, but useful since it's under 'f' namespace
nnoremap <Leader>fg :silent grep<Space>
nnoremap <silent> [f :cp<CR>
nnoremap <silent> ]f :cn<CR>
