(
  (function_call
    (field_expression
      (property_identifier) @_nvim_exec_method)
    (arguments
      (string) @vim)
  )

  (#eq? @_nvim_exec_method "nvim_exec")
)

(
  (function_call
    (field_expression
      (identifier) @_vim_global
      (property_identifier) @_cmd)
    (arguments
      (string) @vim)
  )

  (#eq? @_vim_global "vim")
  (#eq? @_cmd "cmd")
)
