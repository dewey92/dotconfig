local utils = require('my.utils')
local g = vim.g

local options = {
  cursorline = true,
  background = 'dark',
  laststatus = 2,
  showmode = false,    -- We don't need to see things like -- INSERT -- anymore
  t_Co = '256',        -- Support 256 colors
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
    lightline_theme = 'gruvbox8'

    vim.api.nvim_exec([[ autocmd ColorScheme * hi Normal guibg=#10151a ]], false)
  elseif theme == 'embark' then -- It's nice but colors in lazygit are broken
    g.embark_terminal_italics = 1
    lightline_theme = 'embark'

    vim.cmd [[ packadd embark ]]
  elseif theme == 'miramare' then
    g.miramare_enable_italic = 1
    g.miramare_current_word = 'bold'
    lightline_theme = 'miramare'

    vim.cmd [[ packadd miramare ]]
  elseif theme == 'material' then
    g.material_style = 'deep ocean'
    g.material_italic_comments = 1
    g.material_italic_keywords = 1
    g.material_italic_functions = 1

    lightline_theme = 'material'

    vim.cmd [[ packadd colorbuddy.nvim ]]
    vim.cmd [[ packadd material.nvim ]]
  elseif theme == 'moonfly' then
    lightline_theme = 'moonfly'
  end

  vim.cmd('colorscheme ' .. theme)
end

load_theme('embark')

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
    cocstatus = 'coc#status',
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
-- Git blame
--------------------------------------------------------------------------------
g.gitblame_message_template = '<committer>, <committer-date> • <summary> • <sha>'
g.gitblame_date_format = '%d %b %Y'

--------------------------------------------------------------------------------
-- etc
--------------------------------------------------------------------------------

vim.api.nvim_exec([[
  " Use autocmd to force lightline update.
  " autocmd User CocStatusChange,CocDiagnosticChange call lightline#update()

  " Enable hybrid line numbering, only for the focused buffer
  set number relativenumber
  augroup numbertoggle
    autocmd!
    autocmd BufEnter,FocusGained,WinEnter * if &nu | set rnu   | endif
    autocmd BufLeave,FocusLost,WinLeave   * if &nu | set nornu | endif
  augroup END

  " Create whitespace group
  highlight ExtraWhitespace ctermbg=red guibg=red
  match ExtraWhitespace /\s\+$/
  autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
  autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
  autocmd InsertLeave * match ExtraWhitespace /\s\+$/
  autocmd BufWinLeave * call clearmatches()

  " Automatically rebalance windows on vim resize
  autocmd VimResized * :wincmd =
]], false)
