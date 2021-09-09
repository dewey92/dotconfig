nmap <silent> <Leader>ss <CMD>HopChar2<CR>
xmap <silent> <Leader>ss <CMD>HopChar2<CR>

nmap <silent> <Leader>sj <CMD>HopWord<CR>
xmap <silent> <Leader>sj <CMD>HopWord<CR>

nmap <silent> <Leader>s<space> <CMD>HopPattern<CR>
xmap <silent> <Leader>s<space> <CMD>HopPattern<CR>

" Not really Hop specific mapping, but useful since it's under 's' namespace
" for Search-and-replace
nnoremap <Leader>sg :silent Rg<Space>
nnoremap <Leader>sr :%s///g<Left><Left>
xnoremap <Leader>sr :s///g<Left><Left>

" https://gist.github.com/romainl/56f0c28ef953ffc157f36cc495947ab3
augroup SearchInQf
  au!
  autocmd BufReadPost quickfix nnoremap <buffer> <Leader>sr :cfdo %s///g \| update<C-Left><C-Left><Left><Left><Left>
augroup END

function! Grep(...)
  return system(join([&grepprg] + [expandcmd(join(a:000, ' '))], ' '))
endfunction
command! -nargs=+ -complete=file_in_path -bar Rg  cgetexpr Grep(<f-args>)
command! -nargs=+ -complete=file_in_path -bar LRg lgetexpr Grep(<f-args>)
