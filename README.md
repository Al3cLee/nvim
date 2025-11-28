# nvim

My NeoVim setup folder. I use [LazyVim](https://lazyvim.org)
with the [WezTerm](https://wezterm.org) terminal emulator.

Notably, in [`lua/typst_math.lua`](https://github.com/Al3cLee/nvim/tree/main/lua/typst_math.lua) I defined a helper that
uses `treesitter` parsing tools to determine whether
the cursor is inside a `typst` math environment, thus
enabling math-only snippets (see [`LuaSnip/typst.lua`](https://github.com/Al3cLee/nvim/tree/main/LuaSnip/typst.lua)).

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

The file `https://github.com/Al3cLee/nvim/blob/main/templates/Typst_templates.typ`
implements a Typst template file that allows

- freely switching between `touying` and a regular document,
- stand-alone compiling of child files, and
- correct bibliography for both child files and the main file.

See the comments in `Typst_templates.typ` for usage details.
