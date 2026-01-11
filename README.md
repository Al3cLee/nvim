# nvim

My NeoVim setup folder. I use
[LazyVim](https://lazyvim.org)
with the
[WezTerm](https://wezterm.org)
terminal emulator.

## Requirements

This setup should be mostly re-producible,
because I have a very limited amount of plugins, and
most heavy-lifting is done by LazyVim.

The `Julia` language support, however,
requires additional care, because the Julia
language server is a package instead of a binary,
so it cannot be naively managed by `mason.nvim`.

The language server is set up under instructions
given in the
[docs of nvim-lspconfig](https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md#julials),
and the `julia-vim` plugin takes care of
LaTeX-to-Unicode conversion.
Formatting is provided by `JuliaFormatter`, a dependency
of `LanguageServer.jl`. Apart from
project-specific `.JuliaFormatter.toml` files,
I also have a `~/.JuliaFormatter.toml` on my machine
as a back-up.

## Typst templates

The file
[templates/typst_templates.typ](https://github.com/Al3cLee/nvim/blob/main/templates/typst_templates.typ)
implements a Typst template file that allows

- freely switching between `touying` and a regular document,
- stand-alone compiling of child files, and
- correct bibliography for both child files and the main file.

Among these, the main difficulty was to avoid
multiple-bibliography conflict while still suppressing
missing-citation warnings in child files.
This was achieved under the guidance provided
in
[this forum post](https://forum.typst.app/t/how-to-share-bibliography-in-a-multi-file-setup/1605/9).
Note, however, that the function `load-bib` provided
there needs a small change; see my
`typst_templates.typ` for details.
The counter for `bibs` should not update itself,
so I removed the condition `counter("bibs").get().first() == 1`.

The mental model is that, in a project,

- the `preamble.typ` file stores functions and templates to map contents to formatted output,
- some `child.typ` files store contents, and
- the `main.typ` file collects various `child` files together via `#include`.

Specifically, the main file should **not** include any
`show` rules; at least, its show rules should be orthogonal
to those in child files.

I implemented the (very opinionated) approach where each child file can be
compiled stand-alone without errors, and
look exactly the same as the main file
(except for the numberings, of course).
This approach is motivated by my enthusiasm to
atomize my notes:
I try to write short notes and then combine them
when I need to.
For reasons why this is beneficial,
see this page:
[Atomic Notes](https://wentaoli.xyz/atomic_notes).

The setup for regular documents and `touying` files
are slightly different.
This is because:
in a child file, setting show rules related to page size
causes page breaks in the main document,
but I don't necessarily want page breaks
between child files,
while in `touying` documents,
page breaks are just new slides, which are acceptable.
Therefore, I set the page size and numberings
in the main file for regular documents,
while `touying` documents have main files that
do not `show` anything.

---

Below is a minimum working example for regular documents.
Each file needs to import the preamble
and specify a show rule.
For bibliography integration, an additional show rule is needed.

```typst
// preamble.typ
// This should be exactly the same as
// templates/typst_templates.typ.
// You can use the vim command :TypstTemplate
// to paste that file if you use this setup.
```

```typst
// main.typ
#import "preamble.typ": *
#show: template-doc-main
#show: bib-main-doc // Use this line if you have bibliography

#include "child.typ"
```

```typst
// child.typ
#import "preamble.typ": *
#show: template-doc
#show: bib-child

#lorem(30) // Random text
```

---

For `touying` files, a minimal setup is

```typst
// preamble.typ
// This is the same as
// templates/typst_templates.typ
```

```typst
// main.typ
#import "preamble.typ": *
// This import is just for safety

#include "cover.typ"
#include "child_slide.typ"
#include "bib_slide.typ"
```

```typst
// cover.typ
#import "preamble.typ": *
#show: template-touying

#title-slide()
```

```typst
// child_slide.typ
#import "preamble.typ": *
#show: template-touying
#show: bib-child

= Section Title
---
// this means new slide in touying!
// I use the metropolis theme,
// which only creates new slides
// for 2nd-level headers.
// Therefore it is a must to
// manually add "---" after 1st-level headers,
// otherwise the text following this header
// will be very big.
```

```typst
// bib_slide.typ
#import "preamble.typ": *
#show: template-touying
#show: bib-child // Actually, this line is not necessary

#bib-slide()
```

---

It is _strongly advised_ to keep all contents in child files
in this multiple-file setup. For `touying` this structure
does not allow contents in `main.typ`; for `doc` you can `#show: template-doc` in `main.typ`
and write contents.

## LuaSnip

In
[`lua/typst_math.lua`](https://github.com/Al3cLee/nvim/tree/main/lua/typst_math.lua)
I defined a module that
uses `treesitter` parsing tools to determine whether
the cursor is inside a `typst` math environment, thus
enabling math-only snippets (see
[`LuaSnip/typst.lua`](https://github.com/Al3cLee/nvim/tree/main/LuaSnip/typst.lua)
).

A similar treatment is applied to Markdown files
in `lua/markdown_math.lua` and
`LuaSnip/markdown.lua`.
