" Config {{{
" ______
set rtp+=/usr/local/opt/fzf
let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.6 } }
let g:fzf_preview_window = 'right:60%'

let $FZF_DEFAULT_OPTS = '--layout=reverse --inline-info'
let $FZF_DEFAULT_COMMAND = "rg --files --hidden --follow --glob '!.git/**'"

let g:my_fzf_default_opts = ['--layout=reverse', '--inline-info', '--preview "bat --style=numbers --color=always --theme=TwoDark {}"']

" Customize fzf colors to match your color scheme
let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }

" Get Files
command! -bang -nargs=? -complete=dir Files
			\ call fzf#vim#files(<q-args>, fzf#vim#with_preview({'options': g:my_fzf_default_opts }), <bang>0)

" Make Ripgrep ONLY search file contents and not filenames
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   'rg --column --line-number --hidden --smart-case --no-heading --color=always '.shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview({'options': '--delimiter : --nth 4..'}, 'up:60%')
  \           : fzf#vim#with_preview({'options': '--delimiter : --nth 4.. -e'}, 'right:50%', '?'),
  \   <bang>0)

" Git grep
command! -bang -nargs=* GGrep
  \ call fzf#vim#grep(
  \   'git grep --line-number '.shellescape(<q-args>), 0,
	\   fzf#vim#with_preview({'dir': systemlist('git rev-parse --show-toplevel')[0], 'options': g:my_fzf_default_opts }), <bang>0)

" }}}
" Mapping {{{
" _______

" Find files in current dir
nnoremap <silent> <Leader>. :execute 'FZF' expand('%:p:h')<CR>

" Find files in project folder
nnoremap <silent> <Leader><Leader> :GFiles <CR>

" List all open buffers
nnoremap <silent> <Leader>bb :Buffers <CR>

" Search current buffers
nnoremap <silent> <Leader>sb :BLines <CR>

" Search queries project-wide
nnoremap <silent> <Leader>sp :Rg <CR>
xmap <silent> <Leader>sp "sy:Rg <CR><M-r>s

" Open vim config dir
nnoremap <silent> <Leader>fp :FZF ~/.config/nvim <CR>

" Emac's M-x
nnoremap <silent> <Leader>: :Commands<CR>
nnoremap <silent> <M-x> :Commands<CR>

" Toggle colorschemes
nnoremap <silent> <Leader>ht :Colors<CR>
