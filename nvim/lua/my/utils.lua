local M = {}

M.apply_options = function(opts)
  for k, v in pairs(opts) do
    vim.o[k] = v
  end
end

-- Equivalent to `synIDattr(hlID(group), attr)`, but stricter since
-- `vim.api.nvim_get_hl_by_name` will throw if the hl group is not found
M.get_hlgroup_attr = function(group, attr)
  return ('#%06x'):format(vim.api.nvim_get_hl_by_name(group, true)[attr])
end

M.get_icon = function (path)
  return require'nvim-web-devicons'.get_icon(
    vim.fn.fnamemodify(path, ':t'),
    vim.fn.fnamemodify(path, ':e')
  )
end

return M
