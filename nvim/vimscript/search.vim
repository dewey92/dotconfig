" Search-and-replace
nnoremap <Leader>sg :silent Rg<Space>
xnoremap <Leader>sG "ry \|:slent Rg<Space><C-r>r
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
