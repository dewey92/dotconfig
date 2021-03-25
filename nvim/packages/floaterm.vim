let g:floaterm_keymap_new    = '<Leader>ot'
let g:floaterm_keymap_prev   = '<Leader>tp'
let g:floaterm_keymap_next   = '<Leader>tn'
let g:floaterm_keymap_toggle = '<Leader>tt'

let g:floaterm_autoclose = 1

nnoremap <silent> <Leader>gg :FloatermNew lazygit<CR>
nnoremap <silent> <Leader>oe :FloatermNew ranger<CR>
nnoremap <silent> <Leader>tj :FloatermNew --wintype=split --height=6<CR>
