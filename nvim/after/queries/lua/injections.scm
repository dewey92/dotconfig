(
  (function_call
    (dot_index_expression
      field: (identifier) @_nvim_exec_method)
    (arguments
      (string) @vim)
  )

  (#eq? @_nvim_exec_method "nvim_exec")
)

(
  (function_call
    (dot_index_expression
      table: (identifier) @_vim_global
      field: (identifier) @_cmd)
    (arguments
      (string) @vim)
  )

  (#eq? @_vim_global "vim")
  (#eq? @_cmd "cmd")
)
