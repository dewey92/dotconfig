local g = vim.g

vim.filetype.add({
  extension = {
    mdx = "mdx",
  },
})
vim.treesitter.language.register("markdown", "mdx")

-- Purescript
g.purescript_disable_indent = 1
--[[ g.purescript_indent_do = 2
g.purescript_indent_where = 2
g.purescript_indent_case = 2
g.purescript_indent_in = 0 ]]

-- Markdown
g.vim_markdown_fenced_languages = {
  'html',
  'javascript',
  'javascriptreact',
  'typescript',
  'ts=typescript',
  'tsx=typescript',
  'bash=sh',
  'haskell',
  'hs=haskell',
}
vim.g.markdown_recommended_style = 0

vim.cmd [[
  augroup Markdown
    au!
    au FileType markdown
      \  nnoremap <buffer> j gj
      \| nnoremap <buffer> k gk
  augroup END
]]
