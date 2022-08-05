local wezterm = require 'wezterm'
local act = wezterm.action

local mods = 'CTRL|SHIFT'

return {
  adjust_window_size_when_changing_font_size = false,
  color_scheme = 'Gruvbox Dark',
  enable_scroll_bar = false,
  font = wezterm.font('JetBrains Mono', { weight = 'Medium' }),
  font_size = 10,
  foreground_text_hsb = {
    brightness = 1.3,
  },
  hide_tab_bar_if_only_one_tab = true,
  inactive_pane_hsb = {
    saturation = 0.7,
    brightness = 0.8,
  },
  line_height = 1.2,
  use_fancy_tab_bar = false,
  window_background_opacity = 0.88,
  window_decorations = 'NONE',

  -- Mappings
  keys = {
    {
      mods = 'CTRL',
      key = 't',
      action = act.SpawnTab 'CurrentPaneDomain',
    },
    {
      mods = mods,
      key = 'LeftArrow',
      action = act.ActivateTabRelative(-1),
    },
    {
      mods = mods,
      key = 'RightArrow',
      action = act.ActivateTabRelative(1),
    },
    {
      mods = mods,
      key = '<',
      action = act.MoveTabRelative(-1),
    },
    {
      mods = mods,
      key = '>',
      action = act.MoveTabRelative(1),
    },
    {
      mods = mods,
      key = 'Enter',
      action = act.SplitVertical,
    },
    {
      mods = mods,
      key = '{',
      action = act.ActivatePaneDirection 'Prev',
    },
    {
      mods = mods,
      key = '}',
      action = act.ActivatePaneDirection 'Next',
    },
  },
}
