local ls = require "luasnip"
local s = ls.snippet
local i = ls.insert_node
local fmt = require("luasnip.extras.fmt").fmt

ls.add_snippets("go", {
  s("pf", fmt([[fmt.Printf("{}\n", {})]], { i(1, "msg"), i(2, "val") })),
  s(
    "fn",
    fmt(
      [[
    func {}({}) {} {{
      {}
    }}
  ]],
      { i(1, "name"), i(2), i(3, "error"), i(4) }
    )
  ),
})
