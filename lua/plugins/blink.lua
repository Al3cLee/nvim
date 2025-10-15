return {
  "saghen/blink.cmp",
  version = "1.*",
  -- `main` is untested, please open a PR if you've confirmed it works as expected
  dependencies = { "L3MON4D3/LuaSnip", version = "v2.*" },
  opts = {
    fuzzy = { implementation = "prefer_rust_with_warning" },
    snippets = { preset = "luasnip" },
    -- ensure you have the `snippets` source (enabled by default)
    sources = {
      default = { "lsp", "path", "snippets", "buffer" },
    },
  },
}
