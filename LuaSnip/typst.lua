-- Navigate this file by searching for `#`
-- Requirements:
--     https://typst.app/universe/package/physica
local cond = require("typst_math") -- adjust require path
local ls = require("luasnip")
local s, t, i = ls.snippet, ls.text_node, ls.insert_node
local f = ls.function_node
local d = ls.dynamic_node
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
local rep = require("luasnip.extras").rep

return {

  -- # basic symbols

  s(
    { wordTrig = false, trig = "hr", dscr = "higher text", snippetType = "autosnippet", condition = cond.in_typst_math },
    {
      t({ "^(" }),
      i(1),
      t({ ")" }),
    }
  ),

  s(
    { wordTrig = false, trig = "lr", dscr = "lower text", snippetType = "autosnippet", condition = cond.in_typst_math },
    {
      t({ "_(" }),
      i(1),
      t({ ")" }),
    }
  ),

  s({ wordTrig = false, trig = "sr", dscr = "square", snippetType = "autosnippet", condition = cond.in_typst_math }, {
    t({ "^(2)" }),
  }),

  s(
    { wordTrig = false, trig = "invs", dscr = "inverse", snippetType = "autosnippet", condition = cond.in_typst_math },
    {
      t({ "^(-1)" }),
    }
  ),

  s(
    { wordTrig = false, trig = "tsps", dscr = "transpose", snippetType = "autosnippet", condition = cond.in_typst_math },
    {
      t({ "^(TT)" }),
    }
  ),

  s({ wordTrig = false, trig = "dag", dscr = "dagger", snippetType = "autosnippet", condition = cond.in_typst_math }, {
    t({ "^(dagger)" }),
  }),

  s(
    { wordTrig = false, trig = "input", dscr = "input", snippetType = "autosnippet", condition = cond.in_typst_math },
    {
      t({ "\\( bullet \\)" }),
    }
  ),

  s({ wordTrig = true, trig = "of", dscr = "of", snippetType = "autosnippet", condition = cond.in_typst_math }, {
    t({ "\\(" }),
    i(1),
    t({ "\\)" }),
  }),

  s({ wordTrig = true, trig = "lm", dscr = "inline math", snippetType = "autosnippet" }, {
    t({ "$" }),
    i(1),
    t({ "$" }),
  }),

  s({ wordTrig = true, trig = "dm", dscr = "display math", snippetType = "autosnippet" }, {
    t({ "$ " }),
    i(1),
    t({ " $" }),
  }),

  s({ wordTrig = true, trig = "wrt", dscr = "with respect to", snippetType = "autosnippet" }, {
    t({ "with respect to" }),
  }),

  s(
    { wordTrig = true, trig = "vb", dscr = "verbose block", snippetType = "autosnippet" },
    fmta(
      [[
      ```<>
      <>
      ```
    ]],
      { i(1), i(2) }
    )
  ),

  s({ wordTrig = false, trig = "jia", dscr = "+", snippetType = "autosnippet", condition = cond.in_typst_math }, {
    t({ "+" }),
  }),

  s({ wordTrig = false, trig = "jien", dscr = "-", snippetType = "autosnippet", condition = cond.in_typst_math }, {
    t({ "-" }),
  }),

  s({ wordTrig = false, trig = "xx", dscr = "cross", snippetType = "autosnippet", condition = cond.in_typst_math }, {
    t({ "times" }),
  }),

  s({ wordTrig = false, trig = "dy", dscr = "=", snippetType = "autosnippet", condition = cond.in_typst_math }, {
    t({ "=" }),
  }),

  s(
    { wordTrig = false, trig = "ii", dscr = "upright i", snippetType = "autosnippet", condition = cond.in_typst_math },
    {
      t({ '"i"' }),
    }
  ),

  s(
    { wordTrig = false, trig = "ee", dscr = "upright e", snippetType = "autosnippet", condition = cond.in_typst_math },
    {
      t({ '"e"' }),
    }
  ),

  s({ wordTrig = false, trig = "ev", dscr = "expval", condition = cond.in_typst_math }, {
    t({ "expval(" }),
    i(1),
    t({ ")" }),
  }),

  s({
    wordTrig = false,
    trig = "at",
    dscr = "evaluated at",
    snippetType = "autosnippet",
    condition = cond.in_typst_math,
  }, {
    t({ "evaluated(" }),
    i(1),
    t({ ")" }),
  }),
  -- # Regex expansions

  s(
    {
      trig = "([%a])([%d])",
      regTrig = true,
      wordTrig = false,
      snippetType = "autosnippet",
      condition = cond.in_typst_math,
    },
    fmta("<>_(<>)", {
      f(function(_, snip)
        return snip.captures[1]
      end),
      f(function(_, snip)
        return snip.captures[2]
      end),
    })
  ),

  s(
    {
      trig = "(%a+)(ket)",
      regTrig = true,
      wordTrig = false,
      snippetType = "autosnippet",
      condition = cond.in_typst_math,
    },
    fmta("ket(<>)", {
      f(function(_, snip)
        return snip.captures[1]
      end),
    })
  ),

  s(
    {
      trig = "(%a+)(bra)",
      regTrig = true,
      wordTrig = false,
      snippetType = "autosnippet",
      condition = cond.in_typst_math,
    },
    fmta("bra(<>)", {
      f(function(_, snip)
        return snip.captures[1]
      end),
    })
  ),

  s(
    {
      trig = "(%a+)(va)",
      regTrig = true,
      priority = 100,
      wordTrig = false,
      snippetType = "autosnippet",
      condition = cond.in_typst_math,
    },
    fmta("va(<>)", {
      f(function(_, snip)
        return snip.captures[1]
      end),
    })
  ),

  s(
    {
      trig = "(%a+)(td)",
      regTrig = true,
      wordTrig = false,
      snippetType = "autosnippet",
      condition = cond.in_typst_math,
    },
    fmta("tilde(<>)", {
      f(function(_, snip)
        return snip.captures[1]
      end),
    })
  ),

  s(
    {
      trig = "(%a+)(ht)",
      regTrig = true,
      wordTrig = false,
      snippetType = "autosnippet",
      condition = cond.in_typst_math,
    },
    fmta("hat(<>)", {
      f(function(_, snip)
        return snip.captures[1]
      end),
    })
  ),

  s(
    {
      trig = "(%a+)(cal)",
      regTrig = true,
      wordTrig = false,
      snippetType = "autosnippet",
      condition = cond.in_typst_math,
    },
    fmta("cal(<>)", {
      f(function(_, snip)
        return snip.captures[1]
      end),
    })
  ),

  s(
    {
      trig = "(%a+)(dt)",
      regTrig = true,
      wordTrig = false,
      snippetType = "autosnippet",
      condition = cond.in_typst_math,
    },
    fmta("dot(<>)", {
      f(function(_, snip)
        return snip.captures[1]
      end),
    })
  ),
}
