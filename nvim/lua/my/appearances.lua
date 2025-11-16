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
  if theme == 'gruvbox8_hard' then
    g.gruvbox_contrast_dark = 'hard'
    g.gruvbox_bold = 1
    g.gruvbox_underline = 1
    g.gruvbox_undercurl = 1
    g.gruvbox_plugin_hi_groups = 0
    g.gruvbox_transp_bg = 0
    lightline_theme = 'gruvbox8'

    vim.cmd [[ autocmd ColorScheme * hi Normal guibg=#10151a ]]
    vim.cmd [[ packadd vim-gruvbox8 ]]

  elseif theme == 'catppuccin' then
    lightline_theme = 'catppuccin'
    theme = 'catppuccin-mocha'

    vim.cmd [[ packadd catppuccin ]]

    require('catppuccin').setup({
      kitty = false,
      styles = {
        keywords = {'bold'},
        strings = {'italic'},
      },
      color_overrides = {
        mocha = {
          rosewater = "#efc9c2",
          flamingo = "#ebb2b2",
          pink = "#f2a7de",
          mauve = "#b889f4",
          red = "#ea7183",
          maroon = "#ea838c",
          peach = "#f39967",
          yellow = "#eaca89",
          green = "#96d382",
          teal = "#78cec1",
          sky = "#91d7e3",
          sapphire = "#68bae0",
          blue = "#739df2",
          lavender = "#a0a8f6",
          text = "#b5c1f1",
          subtext1 = "#a6b0d8",
          subtext0 = "#959ec2",
          overlay2 = "#848cad",
          overlay1 = "#717997",
          overlay0 = "#63677f",
          surface2 = "#505469",
          surface1 = "#3e4255",
          surface0 = "#2c2f40",
          -- base = "#1a1c2a",
          base = "#10151a",
          mantle = "#141620",
          crust = "#0e0f16",
        },
      },
    })
  end

  vim.cmd('colorscheme ' .. theme)
end

-- Transparent
-- vim.cmd [[ autocmd ColorScheme * hi Normal guibg=NONE ]]
-- vim.cmd [[ autocmd ColorScheme * hi NormalNC guibg=NONE ]]
-- vim.cmd [[ autocmd ColorScheme * hi NonText guibg=NONE ]]
-- vim.cmd [[ autocmd ColorScheme * hi EndOfBuffer guibg=NONE ]]
-- vim.cmd [[ autocmd ColorScheme * hi SignColumn guibg=NONE ]]
-- vim.cmd [[ autocmd ColorScheme * set laststatus=3 ]]
load_theme('catppuccin')

--------------------------------------------------------------------------------
-- Lightline
--------------------------------------------------------------------------------
g.lightline = {
  colorscheme = lightline_theme,
  active = {
    left = { {'mode'}, {'getIconLightline'}, {'readonly', 'relativepath', 'modified'} },
    right = { {'lineinfo', 'indentation'}, {'percent'}, {'filetype'} },
  },
  inactive = {
    left = { {'getIcon'}, {'filename'} },
    right = { {'lineinfo'}, {'percent'} },
  },
  component_function = {
    getIconLightline = 'GetIconLightline',
    indentation = 'GetIndentChar',
  }
}

_G.get_icon_lightline = function ()
  local icon, hlgroup = utils.get_icon(vim.fn.expand('%'))
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

vim.api.nvim_exec2([[
function! GetIconLightline()
  return v:lua.get_icon_lightline()
endfunction

function! GetIndentChar()
  return &expandtab == 1 ? 'Space' : 'Tab'
endfunction
]], {})

--------------------------------------------------------------------------------
-- Git diff
--------------------------------------------------------------------------------
vim.api.nvim_exec2([[
  hi DiffAdd gui=NONE guifg=NONE guibg=#555714
  hi DiffChange gui=NONE guifg=NONE guibg=#6e5213
  hi DiffDelete gui=NONE guifg=NONE guibg=#4d160f
]], {})

--------------------------------------------------------------------------------
-- Windows
--------------------------------------------------------------------------------
vim.api.nvim_exec2([[
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

  " Quickfix should always be at the bottom
  autocmd FileType qf wincmd J
]], {})

--------------------------------------------------------------------------------
-- etc
--------------------------------------------------------------------------------
vim.api.nvim_exec2([[
  " Enable hybrid line numbering, only for the focused buffer
  set number relativenumber
  augroup numbertoggle
    au!
    au BufEnter,FocusGained,WinEnter * if &nu | set rnu   | endif
    au BufLeave,FocusLost,WinLeave   * if &nu | set nornu | endif
  augroup END

  " Create whitespace group
  highlight ExtraWhitespace ctermbg=DarkRed guibg=DarkRed
  augroup HighlightTrailingSpace
    au!
    au BufWinEnter * if !empty(&ft) | match ExtraWhitespace /\s\+$/ | endif
    au InsertEnter * if !empty(&ft) | match ExtraWhitespace /\s\+\%#\@<!$/ | endif
    au InsertLeave * if !empty(&ft) | match ExtraWhitespace /\s\+$/ | endif
    au BufWinLeave * call clearmatches()
  augroup END

  augroup HighlightMixedIndentations
    au!
    au BufWinEnter * if !empty(&ft) && &expandtab == 0 | match ExtraWhitespace /^\t*\zs \+/ | endif
    au InsertLeave * if !empty(&ft) && &expandtab == 0 | match ExtraWhitespace /^\t*\zs \+/ | endif

    au BufWinEnter * if !empty(&ft) && &expandtab == 1 | match ExtraWhitespace /^ *\zs\t\+/ | endif
    au InsertLeave * if !empty(&ft) && &expandtab == 1 | match ExtraWhitespace /^ *\zs\t\+/ | endif
    au BufWinLeave * call clearmatches()
  augroup END
]], {})
