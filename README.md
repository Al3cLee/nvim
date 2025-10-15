# nvim

My NeoVim setup folder. I use [LazyVim](https://lazyvim.org)
with the [WezTerm](https://wezterm.org) terminal emulator.

Notably, in `lua/typst_math.lua` I defined a helper that
uses `treesitter` parsing tools to determine whether
the cursor is inside a `typst` math environment, thus
enabling math-only snippets (see `lua/plugins/luasnip.lua`).
