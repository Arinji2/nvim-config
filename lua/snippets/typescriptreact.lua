local ls = require "luasnip"
local s = ls.snippet
local i = ls.insert_node
local fmt = require("luasnip.extras.fmt").fmt

ls.add_snippets("typescriptreact", {
  -- 1. Basic Page Component
  s(
    { trig = "page", dscr = "Basic Next.js Page component " },
    fmt(
      [[
    export default function Page() {{
      return (
        <div>
          {}
        </div>
      )
    }}

    export default Page
  ]],
      { i(1, "Hello world") }
    )
  ),

  -- 2. Page with async `params`
  s(
    { trig = "pagep", dscr = "Next.js Page component with async `params` (Promise destructured)" },
    fmt(
      [[
    export default async function Page(
      params: Promise<{{ {} }}>
    ) {{
      const {{ {} }} = await params

      return (
        <div>
          {}
        </div>
      )
    }}
  ]],
      {
        i(1, "id: string"),
        i(2, "id"),
        i(3, "Page with params"),
      }
    )
  ),

  -- 3. Page with async `searchParams`
  s(
    { trig = "pages", dscr = "Next.js Page component with async `searchParams` (Promise destructured)" },
    fmt(
      [[
    export default async function Page(
      searchParams: Promise<{{ {} }}>
    ) {{
      const {{ {} }} = await searchParams

      return (
        <div>
          {}
        </div>
      )
    }}
  ]],
      {
        i(1, "q?: string"),
        i(2, "q"),
        i(3, "Page with searchParams"),
      }
    )
  ),

  -- 4. Page with both `params` and `searchParams`
  s(
    { trig = "pageps", dscr = "Next.js Page component with both `params` and `searchParams` (Promise destructured)" },
    fmt(
      [[
    export default async function Page(
      props: Promise<{{ params: {{ {} }}, searchParams: {{ {} }} }}>
    ) {{
      const {{ params, searchParams }} = await props

      return (
        <div>
          {}
        </div>
      )
    }}
  ]],
      {
        i(1, "slug: string"),
        i(2, "q?: string"),
        i(3, "Page with both"),
      }
    )
  ),
})
