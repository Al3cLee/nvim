-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

require("luasnip.loaders.from_lua").load({ paths = "~/.config/nvim/LuaSnip/" })

vim.cmd.colorscheme("ef-cyprus")

-- Set up `julials` manually, since the Julia language server is not a binary and
-- cannot be managed very well by mason.nvim.
-- See https://github.com/julia-vscode/LanguageServer.jl/wiki/Vim-and-Neovim#vimlsp---new-api-in-neovim-011
-- vim.lsp.enable("julials")
vim.lsp.config("jetls", {
  cmd = {
    "jetls",
    "--threads=auto",
    "--",
  },
  filetypes = { "julia" },
  root_markers = { "Project.toml" },
})
vim.lsp.enable("jetls")
vim.opt.spell = true -- Enable spellchecking
vim.opt.spelllang = { "en", "cjk" } -- Set languages
