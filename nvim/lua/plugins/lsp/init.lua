local nvim_lsp = require('lspconfig')

local on_attach = function(client, bufnr)
	local function buf_map(mode, key, value)
		vim.api.nvim_buf_set_keymap(bufnr, mode, key, value, { noremap = true, silent = true })
	end
	local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

	buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

	-- Mappings
	-- buf_map('n', 'gD', '<Cmd>lua vim.lsp.buf.declaration()<CR>')
	buf_map('n', 'gd', ':lua vim.lsp.buf.definition()<CR>')
	buf_map('n', 'gt', ':lua vim.lsp.buf.type_definition()<CR>')
	buf_map('n', 'gD', ':lua vim.lsp.buf.references()<CR>')
	buf_map('n', 'K', ':lua vim.lsp.buf.hover()<CR>')
	-- buf_map('n', 'gi', ':lua vim.lsp.buf.implementation()<CR>')
	-- buf_map('n', '<C-k>', ':lua vim.lsp.buf.signature_help()<CR>')
	-- buf_map('n', '<space>cr', ':lua vim.lsp.buf.rename()<CR>')
	-- buf_map('n', '<space>ce', ':lua vim.lsp.diagnostic.show_line_diagnostics()<CR>')
	-- buf_map('n', '[e', ':lua vim.lsp.diagnostic.goto_prev()<CR>')
	-- buf_map('n', ']e', ':lua vim.lsp.diagnostic.goto_next()<CR>')
	buf_map('n', '<Leader>ce', ':lua vim.lsp.diagnostic.set_loclist()<CR>')

	-- Set some keybinds conditional on server capabilities
	if client.resolved_capabilities.document_formatting then
		buf_map('n', '<space>cf', ':lua vim.lsp.buf.formatting()<CR>')
	elseif client.resolved_capabilities.document_range_formatting then
		buf_map('n', '<space>cf', ':lua vim.lsp.buf.range_formatting()<CR>')
	end
end

--------------------------------------------------------------------------------
-- LANGUAGE SERVERS
--------------------------------------------------------------------------------
nvim_lsp.intelephense.setup { on_attach = on_attach }

local function setup_ts_code_actions(bufnr)
	require('nvim-lsp-ts-utils').setup {}

	_G.tsserver_actions = function()
		require('plugins.telescope').run_command({
			prompt_title = 'TsServer Actions',
			commands = {
				{ text = 'Organize imports', command = 'LspOrganize' },
				{ text = 'Fix current', command = 'LspFixCurrent' },
				{ text = 'Rename file', command = 'LspRenameFile' },
				{ text = 'Import all', command = 'LspImportAll' },
				{ text = 'Format file', command = 'lua vim.lsp.buf.formatting()' },
			}
		})
	end

	vim.api.nvim_buf_set_keymap(bufnr, 'n', '<Leader>cc', ':call v:lua.tsserver_actions()<CR>', { noremap = true, silent = true })
end

nvim_lsp.tsserver.setup {
	init_options = {
		documentFormatting = true, -- FIXME: Set to false to delegate formatting fully to eslint or prettier
	},
	on_attach = function(client, bufnr)
		if client.config.flags then
			client.config.flags.allow_incremental_sync = true
		end

		setup_ts_code_actions(bufnr)

		on_attach(client)
	end
}

local filetypes = {
	typescript = 'eslint',
	typescriptreact = 'eslint',
}
local linters = {
	eslint = {
		sourceName = 'eslint',
		command = 'eslint_d',
		args = {'--stdin', '--stdin-filename', '%filepath', '--format', 'json'},
		rootPatterns = {'.eslintrc.*', 'package.json'},
		debounce = 100,
		parseJson = {
			errorsRoot = '[0].messages',
			line = 'line',
			column = 'column',
			endLine = 'endLine',
			endColumn = 'endColumn',
			message = '${message} [${ruleId}]',
			security = 'severity'
		},
		securities = {[2] = 'error', [1] = 'warning'}
	}
}
local formatters = {
	eslint = {
		command = 'eslint',
		args = {'--fix', '%filepath'},
	}
}
local formatFiletypes = {
	typescript = 'eslint',
	typescriptreact = 'eslint',
}
nvim_lsp.diagnosticls.setup {
	filetypes = vim.tbl_keys(filetypes),
	init_options = {
		filetypes = filetypes,
		linters = linters,
		formatters = formatters,
		formatFiletypes = formatFiletypes,
	}
}

--[[
local eslint = {
	lintCommand = 'eslint_d -f unix --stdin --stdin-filename ${INPUT}',
	lintIgnoreExitCode = true,
	lintStdin = true,
	lintFormats = { '%f:%l:%c: %m' },
	formatCommand = 'eslint_d --fix-to-stdout --stdin --stdin-filename=${INPUT}',
	formatStdin = true,
}
nvim_lsp.efm.setup {
	cmd = { 'efm-langserver' },
	on_attach = function(client)
		client.resolved_capabilities.rename = false
		client.resolved_capabilities.hover = false
		client.resolved_capabilities.document_formatting = true
		client.resolved_capabilities.completion = false
	end,
	filetypes = { 'typescript', 'typescriptreact' },
	settings = {
		rootMarkers = { '.git', 'package.json' },
		languages = {
			typescript = { eslint },
			typescriptreact = { eslint },
		},
	},
}
]]

local sumneko_root = os.getenv('HOME')..'/Projects/lua-language-server'
nvim_lsp.sumneko_lua.setup {
	cmd = {
		sumneko_root .. '/bin/Linux/lua-language-server',
		'-E',
		sumneko_root .. '/main.lua',
	},
	on_attach = on_attach,
	settings = {
		Lua = {
			runtime = { version = 'LuaJIT', path = vim.split(package.path, ';') },
			diagnostics = {
				enable = true,
				globals = {'vim'},
			},
			workspace = {
				-- Make the server aware of Neovim runtime files
				library = {
					[vim.fn.expand('$VIMRUNTIME/lua')] = true,
					[vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true,
				},
			},
		},
	},
}

--------------------------------------------------------------------------------
-- ICONS yeaaah~~
--------------------------------------------------------------------------------
require('lspkind').init {}

--------------------------------------------------------------------------------
-- LSP SAGA
--------------------------------------------------------------------------------
require('lspsaga').init_lsp_saga {}
local codeaction = require('lspsaga.codeaction')
local rename = require('lspsaga.rename')
local provider = require('lspsaga.provider')
local diagnostic = require('lspsaga.diagnostic')

local k = require('astronauta.keymap')
local nnoremap = k.nnoremap
local vnoremap = k.vnoremap
local opts = { silent = true }

nnoremap {'<Leader>ca', codeaction.code_action, opts }
vnoremap {'<Leader>ca', codeaction.range_code_action, opts }
nnoremap {'<Leader>cr', rename.rename, opts }
nnoremap {'<Leader>cd', provider.preview_definition, opts }

nnoremap {'[e', diagnostic.lsp_jump_diagnostic_prev, opts }
nnoremap {']e', diagnostic.lsp_jump_diagnostic_next, opts }
-- nnoremap {'K', [[ :lua require('lspsaga.hover').render_hover_doc()<CR> ]], opts }
