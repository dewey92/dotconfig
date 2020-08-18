" Make Ranger replace Netrw and be the file explorer
let g:rnvimr_enable_ex = 1

" Make Ranger to be hidden after picking a file
let g:rnvimr_enable_picker = 1

" Disable a border for floating window
let g:rnvimr_draw_border = 0

" Hide the files included in gitignore
let g:rnvimr_hide_gitignore = 1

" Make Neovim wipe the buffers corresponding to the files deleted by Ranger
let g:rnvimr_enable_bw = 1

let g:rnvimr_border_attr = {'fg': 14, 'bg': -1}

" Set up only two columns in miller mode and draw border with both
let g:rnvimr_ranger_cmd = 'ranger --cmd="set column_ratios 1,1"
            \ --cmd="set draw_borders both"'

" Link CursorLine into RnvimrNormal highlight in the Floating window
highlight link RnvimrNormal CursorLine

" Customize the initial layout
let g:rnvimr_layout = {
  \ 'relative': 'editor',
	\ 'width': float2nr(round(0.6 * &columns)),
	\ 'height': float2nr(round(0.6 * &lines)),
	\ 'col': float2nr(round(0.2 * &columns)),
	\ 'row': float2nr(round(0.2 * &lines)),
	\ 'style': 'minimal' }

nnoremap <silent> <Leader>oe :RnvimrToggle<CR>
