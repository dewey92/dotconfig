local utils = require('my.utils')
local g = vim.g

local options = {
  cursorline = true,
  background = 'dark',
  laststatus = 2,
  showmode = false,    -- We don't need to see things like -- INSERT -- anymore
  termguicolors = true,
}

utils.apply_options(options)

local lightline_theme = ''
_G.load_theme = function (theme)
  if theme == 'gruvbox-material' then
    g.gruvbox_material_background = 'hard'
    g.gruvbox_material_enable_italic = 1
    g.gruvbox_material_enable_bold = 1
    g.gruvbox_material_current_word = 'bold'
    g.gruvbox_material_diagnostic_line_highlight = 1
    lightline_theme = 'gruvbox_material'

    vim.cmd [[ packadd gruvbox-material ]]
  elseif theme == 'gruvbox8_hard' then
    g.gruvbox_contrast_dark = 'hard'
    g.gruvbox_bold = 1
    g.gruvbox_underline = 1
    g.gruvbox_undercurl = 1
    g.gruvbox_plugin_hi_groups = 0
    g.gruvbox_transp_bg = 0
    lightline_theme = 'gruvbox8'

    -- vim.cmd [[ autocmd ColorScheme * hi Normal guibg=#10151a ]]

    vim.cmd [[ packadd vim-gruvbox8 ]]
  elseif theme == 'embark' then -- It's nice but colors in lazygit are broken
    g.embark_terminal_italics = 1
    lightline_theme = 'embark'

    vim.cmd [[ packadd embark ]]
  elseif theme == 'tokyonight' then
    g.tokyonight_style = 'night'
    g.tokyonight_italic_functions = true
    lightline_theme = 'tokyonight'

    vim.o.background = 'dark'

    vim.cmd [[ packadd tokyonight.nvim ]]
  elseif theme == 'miramare' then
    g.miramare_enable_italic = 1
    g.miramare_current_word = 'bold'
    lightline_theme = 'miramare'

    vim.cmd [[ packadd miramare ]]
  elseif theme == 'material' then
    g.material_style = 'lighter'
    g.material_italic_comments = 1
    g.material_italic_keywords = 1
    g.material_italic_functions = 1

    lightline_theme = 'material'

    vim.o.background = 'light'

    vim.cmd [[ packadd colorbuddy.nvim ]]
    vim.cmd [[ packadd material.nvim ]]
  elseif theme == 'moonfly' then
    lightline_theme = 'moonfly'
  elseif theme == 'dawnfox' then
    lightline_theme = 'nightfox'

    vim.cmd [[ packadd nightfox.nvim ]]

    require('nightfox').init({
      dim_inactive = true,
    })
  elseif theme == 'kanagawa' then
    lightline_theme = 'kanagawa'

    vim.cmd [[ packadd kanagawa.nvim ]]

    require('kanagawa').setup {}
  elseif theme == 'base16-tomorrow-night' then
    lightline_theme = 'base16-tomorrow-night'
    theme = 'base16-tomorrow-night-eighties'

    vim.cmd [[ packadd nvim-base16 ]]
  end

  vim.cmd('colorscheme ' .. theme)
end

-- Transparent
vim.cmd [[ autocmd ColorScheme * hi Normal guibg=NONE ]]
vim.cmd [[ autocmd ColorScheme * hi NormalNC guibg=NONE ]]
vim.cmd [[ autocmd ColorScheme * hi NonText guibg=NONE ]]
vim.cmd [[ autocmd ColorScheme * hi EndOfBuffer guibg=NONE ]]
vim.cmd [[ autocmd ColorScheme * hi SignColumn guibg=NONE ]]
vim.cmd [[ autocmd ColorScheme * set laststatus=3 ]]
load_theme('kanagawa')

--------------------------------------------------------------------------------
-- Lightline
--------------------------------------------------------------------------------
g.lightline = {
  colorscheme = lightline_theme,
  active = {
    left = { {'mode'}, {'getIconLightline'}, {'readonly', 'relativepath', 'modified'} },
    right = { {'lineinfo'}, {'percent'}, {'filetype'}, {'cocstatus'} },
  },
  inactive = {
    left = { {'getIcon'}, {'filename'} },
    right = { {'lineinfo'}, {'percent'} }
  },
  component_function = {
    getIconLightline = 'GetIconLightline'
  }
}

_G.get_icon_lightline = function ()
  local icon, hlgroup = utils.get_icon(
    vim.fn.expand('%'),
    vim.fn.expand('%')
  )
  local fg = utils.get_hlgroup_attr(hlgroup, 'foreground')

  local function apply_icon_hi(modes)
    for _, mode in ipairs(modes) do
      local bg = utils.get_hlgroup_attr('LightlineLeft_'..mode..'_1', 'background')

      vim.cmd(string.format('hi! LightlineLeft_%s_1 guibg=%s guifg=%s', mode, bg, fg))
    end
  end

  apply_icon_hi({'normal', 'insert', 'visual', 'replace'})
  return icon
end

vim.api.nvim_exec([[
function! GetIconLightline()
  return v:lua.get_icon_lightline()
endfunction
]], false)

--------------------------------------------------------------------------------
-- Startify
--------------------------------------------------------------------------------
_G.get_icon_startify = function (path)
  return utils.get_icon(path)
end

vim.api.nvim_exec([[
function! StartifyEntryFormat() abort
  return 'v:lua.get_icon_startify(absolute_path) . " " . entry_path'
endfunction
]], false)

--------------------------------------------------------------------------------
-- Git diff
--------------------------------------------------------------------------------
vim.api.nvim_exec([[
  hi DiffAdd gui=NONE guifg=NONE guibg=#555714
  hi DiffChange gui=NONE guifg=NONE guibg=#6e5213
  hi DiffDelete gui=NONE guifg=NONE guibg=#4d160f
]], false)

--------------------------------------------------------------------------------
-- Windows
--------------------------------------------------------------------------------
vim.api.nvim_exec([[
  augroup ExpandActiveWin
    au!
    au WinEnter * :call ResizeSplits()
  augroup END

  function! ResizeSplits()
    " No resize for these filetypes
    if &ft =~ 'DiffviewFiles'
      return
    endif

    " No resize for floating windows
    if !empty(nvim_win_get_config(0)['relative'])
      return
    endif

    set winwidth=130
    wincmd =
  endfunction

  " Automatically rebalance windows on vim resize
  autocmd VimResized * :wincmd =
]], false)

--------------------------------------------------------------------------------
-- etc
--------------------------------------------------------------------------------
vim.api.nvim_exec([[
  " Enable hybrid line numbering, only for the focused buffer
  set number relativenumber
  augroup numbertoggle
    au!
    au BufEnter,FocusGained,WinEnter * if &nu | set rnu   | endif
    au BufLeave,FocusLost,WinLeave   * if &nu | set nornu | endif
  augroup END

  " Create whitespace group
  highlight ExtraWhitespace ctermbg=red guibg=red
  augroup HighlightTrailingSpace
    au!
    au BufWinEnter * if !empty(&ft) | match ExtraWhitespace /\s\+$/ | endif
    au InsertEnter * if !empty(&ft) | match ExtraWhitespace /\s\+\%#\@<!$/ | endif
    au InsertLeave * if !empty(&ft) | match ExtraWhitespace /\s\+$/ | endif
    au BufWinLeave * call clearmatches()
  augroup END
]], false)

vim.api.nvim_exec([[
  " set foldmethod=expr
  " set foldexpr=v:lnum==1?'>1':getline(v:lnum)=~'import'?1:nvim_treesitter#foldexpr()
]], false)
