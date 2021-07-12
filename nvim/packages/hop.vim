nmap <silent> <Leader>ss <CMD>HopChar2<CR>
xmap <silent> <Leader>ss <CMD>HopChar2<CR>

nmap <silent> <Leader>sj <CMD>HopWord<CR>
xmap <silent> <Leader>sj <CMD>HopWord<CR>

nmap <silent> <Leader>s<space> <CMD>HopPattern<CR>
xmap <silent> <Leader>s<space> <CMD>HopPattern<CR>

" Not really Hop specific mapping, but useful since it's under 's' namespace
" for Search-and-replace
nnoremap <Leader>sg :silent grep<Space>
nnoremap <Leader>sr :%s///g<Left><Left>
xnoremap <Leader>sr :s///g<Left><Left>
autocmd BufReadPost quickfix nnoremap <buffer> <Leader>sr :cfdo %s/<C-r>s//g \| update<Left><Left><Left><Left><Left><Left><Left><Left><Left><Left><Left>
