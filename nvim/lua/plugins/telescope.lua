local M = {}

local actions = require('telescope.actions')
local builtin = require('telescope.builtin')
local pickers = require('telescope.pickers')
local finders = require('telescope.finders')
local sorters = require('telescope.sorters')
local action_state = require('telescope.actions.state')

require('telescope').setup {
	defaults = {
		vimgrep_arguments = {
			'rg',
			'--color=never',
			'--no-heading',
			'--with-filename',
			'--hidden',
			'--line-number',
			'--column',
			'--smart-case'
		},
		prompt_position = 'top',
		prompt_prefix = '> ',
		selection_caret = '> ',
		entry_prefix = '  ',
		initial_mode = 'insert',
		selection_strategy = 'reset',
		sorting_strategy = 'ascending',
		layout_strategy = 'flex',
		layout_defaults = {
			horizontal = {
				width_padding  = 0.1,
				height_padding = 0.1,
				preview_width  = 0.6,
			},
			vertical = {
				width_padding  = 0.05,
				height_padding = 1,
				preview_height = 0.5,
			},
		},
		file_sorter = sorters.get_fzy_sorter,
		file_ignore_patterns = { 'node_modules' },
		generic_sorter = sorters.get_generic_fuzzy_sorter,
		shorten_path = true,
		winblend = 10,
		preview_cutoff = 200,
		use_less = true,
		set_env = { ['COLORTERM'] = 'truecolor' }, -- default = nil,
		mappings = {
			i = {
				["<TAB>"] = actions.toggle_selection,
				["<C-j>"] = actions.move_selection_next,
				["<C-k>"] = actions.move_selection_previous,
			},
			n = {
				["<TAB>"] = actions.toggle_selection,
				["<C-c>"] = actions.close,
			}
		}
	},
	extensions = {
		fzy_native = {
			override_generic_sorter = false,
			override_file_sorter = true,
		}
	}
}
require('telescope').load_extension('fzy_native')

M.nvim_config = function()
	builtin.find_files {
		cwd = '~/.config/nvim',
		prompt_title = 'NVIM Config',
	}
end

M.find_sibling_files = function()
	builtin.find_files {
		cwd = vim.fn.expand('%:p:h'),
		prompt_title = 'Sibling Files',
	}
end

M.search_string = function(text)
	builtin.grep_string {
		shorten_path = true,
		word_match = "-w",
		only_sort_text = true,
		search = text or ''
	}
end

-- FIXME: putting selected text into register doesn't work
M.visual_search_string = function()
	-- vim.cmd [[noau normal! gv"sy]] -- Put into register s
	-- local text = vim.fn.getreg('s')
	-- M.search_string(text)

	builtin.live_grep {
		default_text = 'blabla'
	}
end

M.run_command = function(opts)
	local commands = opts.commands or {}
	local texts = {}
	for _, pair in pairs(commands) do
		table.insert(texts, pair.text)
	end

	local function run_command(prompt_bufnr)
		local entry = action_state.get_selected_entry(prompt_bufnr)
		actions.close(prompt_bufnr)

		for _, pair in pairs(commands) do
			if (pair.text == entry.value) then
				vim.cmd(pair.command)
				return
			end
		end
	end

	pickers.new(opts, {
		prompt_title = 'Actions',
		finder = finders.new_table({ results = texts }),
		sorter = sorters.get_generic_fuzzy_sorter(opts),
		attach_mappings = function(_, map)
			map('i', '<CR>', run_command)

			return true
		end,
		layout_strategy = 'center',
		results_height = 0.4,
		width = 0.4,
	}):find()
end

-- -----------------------------------------------------------------------------
-- Mappings
-- -----------------------------------------------------------------------------
local k = require('astronauta.keymap')
local nnoremap = k.nnoremap
local xnoremap = k.xnoremap
local opts = { silent = true }

nnoremap { '<Leader><Leader>', builtin.git_files, opts }
nnoremap { '<Leader>,', builtin.find_files, opts }
nnoremap { '<Leader>.', M.find_sibling_files, opts }
nnoremap { '<Leader>bb', builtin.buffers, opts }
nnoremap { '<Leader>fp', M.nvim_config, opts }

nnoremap { '<Leader>sp', builtin.live_grep, opts }
nnoremap { '<Leader>sP', M.search_string, opts } -- very slow for large project
xnoremap { '<Leader>sP', M.visual_search_string, opts }
nnoremap { '<Leader>sb', builtin.current_buffer_fuzzy_find, opts }

nnoremap { '<Leader>ht', builtin.colorscheme, opts }
nnoremap { '<Leader>:', builtin.commands, opts }
nnoremap { '<Leader>;', builtin.commands, opts }

return M
