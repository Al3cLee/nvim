-- For how to write Lua patterns see https://www.lua.org/pil/20.2.html
local cond = require("latex_math") -- adjust require path for LaTeX math detection
local ls = require("luasnip")
local s, t, i = ls.snippet, ls.text_node, ls.insert_node
local f = ls.function_node
local d = ls.dynamic_node
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
local rep = require("luasnip.extras").rep
local greek_letters = {
  "alpha",
  "beta",
  "gamma",
  "delta",
  "epsilon",
  "zeta",
  "eta",
  "theta",
  "iota",
  "kappa",
  "lambda",
  "mu",
  "nu",
  "xi",
  "omicron",
  "pi",
  "rho",
  "sigma",
  "tau",
  "upsilon",
  "phi",
  "chi",
  "psi",
  "omega",
  -- Uppercase variants
  "Alpha",
  "Beta",
  "Gamma",
  "Delta",
  "Epsilon",
  "Zeta",
  "Eta",
  "Theta",
  "Iota",
  "Kappa",
  "Lambda",
  "Mu",
  "Nu",
  "Xi",
  "Omicron",
  "Pi",
  "Rho",
  "Sigma",
  "Tau",
  "Upsilon",
  "Phi",
  "Chi",
  "Psi",
  "Omega",
  -- Variant forms
  "varepsilon",
  "vartheta",
  "varpi",
  "varrho",
  "varsigma",
  "varphi",
  -- Operators
  "exp",
  "sum",
  "int",
  "in",
  "subset",
  "subseteq",
  "otimes",
  "pm",
}

local greek_snippets = {}
for _, letter in ipairs(greek_letters) do
  table.insert(
    greek_snippets,
    s({ trig = letter, snippetType = "autosnippet", wordTrig = true, condition = cond.in_latex_math }, {
      t({ "\\" .. letter }),
    })
  )
end
local snippets = {

  -- basic symbols

  s(
    { wordTrig = false, trig = "hr", dscr = "superscript", snippetType = "autosnippet", condition = cond.in_latex_math },
    {
      t({ "^{" }),
      i(1),
      t({ "}" }),
    }
  ),

  s(
    { wordTrig = false, trig = "lr", dscr = "subscript", snippetType = "autosnippet", condition = cond.in_latex_math },
    {
      t({ "_{" }),
      i(1),
      t({ "}" }),
    }
  ),

  s({ wordTrig = false, trig = "sr", dscr = "square", snippetType = "autosnippet", condition = cond.in_latex_math }, {
    t({ "^{2}" }),
  }),

  s(
    { wordTrig = false, trig = "invs", dscr = "inverse", snippetType = "autosnippet", condition = cond.in_latex_math },
    {
      t({ "^{-1}" }),
    }
  ),

  s(
    { wordTrig = false, trig = "tsps", dscr = "transpose", snippetType = "autosnippet", condition = cond.in_latex_math },
    {
      t({ "^{\\top}" }),
    }
  ),

  s({ wordTrig = false, trig = "dag", dscr = "dagger", snippetType = "autosnippet", condition = cond.in_latex_math }, {
    t({ "^{\\dagger}" }),
  }),

  s({ wordTrig = true, regTrig = true, trig = "lm", dscr = "inline math", snippetType = "autosnippet" }, {
    t({ "$" }),
    i(1),
    t({ "$" }),
  }),

  s({ wordTrig = true, regTrig = true, trig = "dm", dscr = "display math", snippetType = "autosnippet" }, {
    t({ " \\[" }),
    i(1),
    t({ "\\]" }),
  }),

  s({
    wordTrig = true,
    trig = "txt",
    dscr = "text in math",
    snippetType = "autosnippet",
    condition = cond.in_latex_math,
  }, {
    t({ "\\text{" }),
    i(1),
    t({ "}" }),
  }),

  s({ wordTrig = false, trig = "ev", dscr = "expval", snippetType = "autosnippet", condition = cond.in_latex_math }, {
    t({ "\\langle " }),
    i(1),
    t({ " \\rangle" }),
  }),

  s({ wordTrig = false, trig = "jia", dscr = "+", snippetType = "autosnippet", condition = cond.in_latex_math }, {
    t({ "+" }),
  }),

  s({ wordTrig = false, trig = "jien", dscr = "-", snippetType = "autosnippet", condition = cond.in_latex_math }, {
    t({ "-" }),
  }),

  s({ wordTrig = false, trig = "xx", dscr = "cross", snippetType = "autosnippet", condition = cond.in_latex_math }, {
    t({ "\\times" }),
  }),

  s({ wordTrig = false, trig = "dy", dscr = "=", snippetType = "autosnippet", condition = cond.in_latex_math }, {
    t({ "=" }),
  }),

  s(
    { wordTrig = false, trig = "ii", dscr = "upright i", snippetType = "autosnippet", condition = cond.in_latex_math },
    {
      t({ "\\mathrm{i}" }),
    }
  ),

  s(
    { wordTrig = false, trig = "ee", dscr = "upright e", snippetType = "autosnippet", condition = cond.in_latex_math },
    {
      t({ "\\mathrm{e}" }),
    }
  ),

  s({
    wordTrig = false,
    trig = "ykuo",
    dscr = "round brackets",
    snippetType = "autosnippet",
    condition = cond.in_latex_math,
  }, {
    t({ "\\left(" }),
    i(1),
    t({ "\\right)" }),
  }),

  s({
    wordTrig = false,
    trig = "hkuo",
    dscr = "curly brackets",
    snippetType = "autosnippet",
    condition = cond.in_latex_math,
  }, {
    t({ "\\left\\{" }),
    i(1),
    t({ "\\right\\}" }),
  }),

  s({
    wordTrig = false,
    trig = "fkuo",
    dscr = "square brackets",
    snippetType = "autosnippet",
    condition = cond.in_latex_math,
  }, {
    t({ "\\left[" }),
    i(1),
    t({ "\\right]" }),
  }),
  -- Regex expansions

  s(
    {
      trig = "([%a])([%d])",
      regTrig = true,
      wordTrig = false,
      snippetType = "autosnippet",
      condition = cond.in_latex_math,
    },
    fmta("<>_{<>}", {
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
      trig = "([%a\\]+)(ket)",
      regTrig = true,
      wordTrig = false,
      snippetType = "autosnippet",
      condition = cond.in_latex_math,
      priority = 100,
    },
    fmta("\\ket{<>}", {
      f(function(_, snip)
        return snip.captures[1]
      end),
    })
  ),

  s(
    {
      trig = "sket",
      regTrig = true,
      wordTrig = false,
      snippetType = "autosnippet",
      condition = cond.in_latex_math,
      priority = 1000,
    },
    fmta("\\ket{<>}", {
      i(1),
    })
  ),

  s(
    {
      trig = "(%a+)(cal)",
      regTrig = true,
      wordTrig = false,
      snippetType = "autosnippet",
      condition = cond.in_latex_math,
    },
    fmta("\\mathcal{<>}", {
      f(function(_, snip)
        return snip.captures[1]
      end),
    })
  ),

  s(
    {
      trig = "([%a\\]+)(bra)",
      regTrig = true,
      wordTrig = false,
      snippetType = "autosnippet",
      condition = cond.in_latex_math,
    },
    fmta("\\bra{<>}", {
      f(function(_, snip)
        return snip.captures[1]
      end),
    })
  ),

  s(
    {
      trig = "([%a\\]+)(va)",
      regTrig = true,
      wordTrig = false,
      snippetType = "autosnippet",
      condition = cond.in_latex_math,
    },
    fmta("\\vec{<>}", {
      f(function(_, snip)
        return snip.captures[1]
      end),
    })
  ),

  s(
    {
      trig = "([%a\\]+)(td)",
      regTrig = true,
      wordTrig = false,
      snippetType = "autosnippet",
      condition = cond.in_latex_math,
    },
    fmta("\\tilde{<>}", {
      f(function(_, snip)
        return snip.captures[1]
      end),
    })
  ),

  s(
    {
      trig = "([%a\\]+)(ht)",
      regTrig = true,
      wordTrig = false,
      snippetType = "autosnippet",
      condition = cond.in_latex_math,
    },
    fmta("\\hat{<>}", {
      f(function(_, snip)
        return snip.captures[1]
      end),
    })
  ),

  s(
    {
      trig = "(%a+)(bb)",
      regTrig = true,
      wordTrig = false,
      snippetType = "autosnippet",
      condition = cond.in_latex_math,
    },
    fmta("\\mathbb{<>}", {
      f(function(_, snip)
        return snip.captures[1]
      end),
    })
  ),

  s(
    { trig = "env", snippetType = "autosnippet" },
    fmta(
      [[
      \begin{<>}
          <>
      \end{<>}
    ]],
      {
        i(1),
        i(2),
        rep(1), -- this node repeats insert node i(1)
      }
    )
  ),
}

vim.list_extend(snippets, greek_snippets)

return snippets
