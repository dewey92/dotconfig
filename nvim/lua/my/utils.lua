local M = {}

M.apply_options = function(opts)
	for k, v in pairs(opts) do
		vim.o[k] = v
	end
end

M.get_hl = function(group, attr)
	return vim.fn.synIDattr(vim.fn.hlID(group), attr)
end

return M
