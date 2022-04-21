local M = {}

M.apply_options = function (opts)
  for k, v in pairs(opts) do
    vim.opt[k] = v
  end
end

-- Equivalent to `synIDattr(hlID(group), attr)`, but stricter since
-- `vim.api.nvim_get_hl_by_name` will throw if the hl group is not found
M.get_hlgroup_attr = function (group, attr, fallback)
  fallback = fallback or "NONE"
  local hl_exists, hl = pcall(vim.api.nvim_get_hl_by_name, group, true)

  if hl_exists and hl[attr] ~= nil then
    return ('#%06x'):format(hl[attr])
  end

  return fallback
end

M.get_icon = function (path)
  return require'nvim-web-devicons'.get_icon(
    vim.fn.fnamemodify(path, ':t'),
    vim.fn.fnamemodify(path, ':e')
  )
end

M.get_visual_selection = function ()
  -- must exit visual mode or program croaks
  -- :visual leaves ex-mode back to normal mode
  -- use 'gv' to reselect the text
  vim.cmd[[visual]]
  local _, csrow, cscol, _ = unpack(vim.fn.getpos("'<"))
  local _, cerow, cecol, _ = unpack(vim.fn.getpos("'>"))
  local lines = vim.fn.getline(csrow, cerow)
  -- local n = cerow-csrow+1
  local n = vim.tbl_count(lines)
  if n <= 0 then return '' end
  lines[n] = string.sub(lines[n], 1, cecol)
  lines[1] = string.sub(lines[1], cscol)
  print(n, csrow, cscol, cerow, cecol, table.concat(lines, '\n'))
  return table.concat(lines, '\n')
end

-- KEEBS
M.nnoremap = function (tbl)
  vim.keymap.set('n', unpack(tbl))
end
M.vnoremap = function (tbl)
  vim.keymap.set('v', unpack(tbl))
end
M.xnoremap = function (tbl)
  vim.keymap.set('x', unpack(tbl))
end

return M
