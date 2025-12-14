# nvim

My NeoVim setup folder. I use [LazyVim](https://lazyvim.org)
with the [WezTerm](https://wezterm.org) terminal emulator.

## Requirements

This setup should be mostly re-producible,
because I have a very limited amount of plugins, and
most heavy-lifting is done by LazyVim.

The `Julia` language support, however,
requires additional care, because the Julia
language server is a package instead of a binary,
so it cannot be naively managed by `mason.nvim`.

The language server is set up under instructions
given in the [docs of nvim-lspconfig](https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md#julials),
and the `julia-vim` plugin takes care of
LaTeX-to-Unicode conversion.
Formatting is provided by `JuliaFormatter`, a dependency
of `LanguageServer.jl`. Apart from
project-specific `.JuliaFormatter.toml` files,
I also have a `~/.JuliaFormatter.toml` on my machine
as a back-up.

## Typst templates

The file [templates/Typst_templates.typ](https://github.com/Al3cLee/nvim/blob/main/templates/Typst_templates.typ)
implements a Typst template file that allows

- freely switching between `touying` and a regular document,
- stand-alone compiling of child files, and
- correct bibliography for both child files and the main file.

Among these, the main difficulty was to avoid
multiple-bibliography conflict while still suppressing
missing-citation warnings in child files.
This was achieved under the guidance provided
in [this forum post](https://forum.typst.app/t/how-to-share-bibliography-in-a-multi-file-setup/1605/9).

See the comments in `Typst_templates.typ` for usage details.
The mental model is that, in a project,

- the `preamble.typ` file stores functions and templates to map contents to formatted output,
- some `child.typ` files store contents and nothing else, and
- the `main.typ` file decides which templates among `preamble.typ` to use, and which `child.typ` contents to `include`.

This way, `child` files can be re-used in different projects without modification.
To switch from a traditional document to a `touying` project, one only needs to change the `#show` line
in `main.typ` from showing the document template to showing the `touying` template.

## LuaSnip

In [`lua/typst_math.lua`](https://github.com/Al3cLee/nvim/tree/main/lua/typst_math.lua) I defined a module that
uses `treesitter` parsing tools to determine whether
the cursor is inside a `typst` math environment, thus
enabling math-only snippets (see [`LuaSnip/typst.lua`](https://github.com/Al3cLee/nvim/tree/main/LuaSnip/typst.lua)).

A similar treatment is applied to Markdown files
in `lua/markdown_math.lua` and
`LuaSnip/markdown.lua`.
