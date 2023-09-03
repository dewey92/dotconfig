local M = {}

M.search_register = 'r'

-- Keymaps, inline r register for simplicity
local map = vim.keymap.set
map('n', '<Leader>sg', ':Rg<Space>')
map('x', '<Leader>sG', [["ry:Rg<Space><C-r>r]])
map('n', '<Leader>sr', ':%s///g<Left><Left>')
map('x', '<Leader>sr', ':s///g<Left><Left>')
map('x', '<Leader>sR', [["ry:%s/<C-r>r/<C-r>r/g<Left><Left>]])

local function construct_key_strokes (use_register)
  local key_strokes = string.format(
    ':cfdo %%s/%s//g | update<C-Left><C-Left><Left><Left><Left>',
    use_register and vim.fn.getreg(M.search_register) or ''
  )

  return key_strokes
end

vim.api.nvim_create_autocmd('BufReadPost', {
  pattern = 'quickfix',
  callback = function (opts)
    map('n', '<Leader>sr', construct_key_strokes(false), { buffer = opts.buf })
    map('n', '<Leader>sR', construct_key_strokes(true), { buffer = opts.buf })
  end,
})

-- The Rg command
local Rg = function (opts)
  local args_expanded = vim.fn.expandcmd(table.concat(opts.fargs, ' '))
  local command = vim.o.grepprg .. ' ' .. args_expanded

  vim.cmd(string.format('cgetexpr system("%s")', command))
end
vim.api.nvim_create_user_command('Rg', Rg, { bang = true, nargs = '+', complete = 'file_in_path' })

-- Open quickfix window as soon as quickfix is updated
vim.api.nvim_create_autocmd('QuickFixCmdPost', { pattern = 'cgetexpr', command = 'cwin' })

return M
