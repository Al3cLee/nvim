-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

-- Set up `julials` manually, since the Julia language server is not a binary and
-- cannot be managed very well by mason.nvim.
-- See https://github.com/julia-vscode/LanguageServer.jl/wiki/Vim-and-Neovim#vimlsp---new-api-in-neovim-011
vim.lsp.config("jetls", {
  cmd = {
    "jetls",
    "serve",
  },
  filetypes = { "julia" },
  root_markers = { "Project.toml" },
})
vim.lsp.enable("jetls")
vim.opt.spell = true -- Enable spellchecking
vim.opt.spelllang = { "en", "cjk" } -- Set languages
-- Source - https://stackoverflow.com/a/79656109
-- Posted by Jo Totland
-- Retrieved 2026-03-18, License - CC BY-SA 4.0
vim.lsp.config("lua_ls", {
  settings = {
    Lua = {
      diagnostics = {
        globals = { "vim" },
      },
      runtime = {
        version = "LuaJIT",
      },
      workspace = {
        -- Make the server aware of Neovim runtime files
        library = vim.api.nvim_get_runtime_file("", true),
      },
    },
  },
  root_markers = { { ".luarc.json", ".luarc.jsonc" }, ".git" },
})
vim.lsp.enable("lua_ls")
