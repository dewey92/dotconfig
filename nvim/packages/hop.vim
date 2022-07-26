nmap <silent> s <CMD>HopChar2<CR>
xmap <silent> s <CMD>HopChar2<CR>

nmap <silent> <Leader>sj <CMD>HopWord<CR>
xmap <silent> <Leader>sj <CMD>HopWord<CR>

nmap <silent> <Leader>s<space> <CMD>HopPattern<CR>
xmap <silent> <Leader>s<space> <CMD>HopPattern<CR>

nmap <silent> f <CMD>HopChar1CurrentLineAC<CR>
vmap <silent> f <CMD>HopChar1CurrentLineAC<CR>
xmap <silent> f <CMD>HopChar1CurrentLineAC<CR>
nmap <silent> F <CMD>HopChar1CurrentLineBC<CR>
vmap <silent> F <CMD>HopChar1CurrentLineBC<CR>
xmap <silent> F <CMD>HopChar1CurrentLineBC<CR>

" Not really Hop specific mapping, but useful since it's under 's' namespace
" for Search-and-replace
nnoremap <Leader>sg :silent Rg<Space>
nnoremap <Leader>sr :%s///g<Left><Left>
xnoremap <Leader>sr :s///g<Left><Left>
xnoremap <Leader>sR "ry \|:%s/<C-r>r/<C-r>r/g<Left><Left>

" https://gist.github.com/romainl/56f0c28ef953ffc157f36cc495947ab3
augroup SearchInQf
  au!
  au BufReadPost quickfix nnoremap <buffer> <Leader>sr :cfdo %s///g \| update<C-Left><C-Left><Left><Left><Left>
augroup END

function! Grep(...)
  let s:command = join([&grepprg] + [expandcmd(join(a:000, ' '))], ' ')
  return system(s:command)
endfunction

augroup QuickFixSearch
  au!
  au QuickFixCmdPost cgetexpr ++nested cwindow | wincmd J
      \| call setqflist([], 'a', {'title': ':' . s:command})
  au QuickFixCmdPost lgetexpr ++nested lwindow
      \| call setloclist(0, [], 'a', {'title': ':' . s:command})
augroup END

command! -nargs=+ -complete=file_in_path -bar Rg  cgetexpr Grep(<f-args>)
command! -nargs=+ -complete=file_in_path -bar LRg lgetexpr Grep(<f-args>)
