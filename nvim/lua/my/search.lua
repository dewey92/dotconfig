-- Keymaps
local map = vim.keymap.set
map('n', '<Leader>sg', ':Rg<Space>')
map('x', '<Leader>sG', [["ry:Rg<Space><C-r>r]])
map('n', '<Leader>sr', ':%s///g<Left><Left>')
map('x', '<Leader>sr', ':s///g<Left><Left>')
map('x', '<Leader>sR', [["ry:%s/<C-r>r/<C-r>r/g<Left><Left>]])

local Rg = function (opts)
  local args_expanded = vim.fn.expandcmd(table.concat(opts.fargs, ' '))
  local command = vim.o.grepprg .. ' ' .. args_expanded

  vim.cmd(string.format('cgetexpr system("%s")', command))
end
vim.api.nvim_create_user_command('Rg', Rg, { bang = true, nargs = '+', complete = 'file_in_path' })

vim.api.nvim_create_autocmd('QuickFixCmdPost', { pattern = 'cgetexpr', command = 'cwin' })
