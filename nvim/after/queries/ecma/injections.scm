(
  (call_expression
    function: (member_expression
                (identifier) @_styled)
    arguments: (template_string) @css)

  (#match? @_styled "^(linaria|styled)$")
)

(
  (call_expression
    function: (call_expression
                (identifier) @_styled)
    arguments: (template_string) @css)

  (#match? @_styled "^(linaria|styled)$")
)
