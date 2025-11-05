-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

-- Somewhere in your Neovim startup, e.g. init.lua
require("luasnip").config.set_config({ -- Setting LuaSnip config

  -- Enable autotriggered snippets
  enable_autosnippets = true,

  -- Use Tab (or some other key if you prefer) to trigger visual selection
  store_selection_keys = "<Tab>",
})

-- Yes, we're just executing a bunch of Vimscript, but this is the officially
-- endorsed method; see https://github.com/L3MON4D3/LuaSnip#keymaps

local ls = require("luasnip")

vim.keymap.set({ "i" }, "<Tab>", function()
  -- Check if LuaSnip can expand a snippet or jump to the next placeholder.
  -- If true, return the string for LuaSnip's expand/jump action.
  -- If false, return the string for a literal <Tab> insertion.
  return ls.expand_or_jumpable() and "<Plug>luasnip-expand-or-jump" or "<Tab>"
end, { silent = true, expr = true })

-- For jumping backwards, this remains the same as before:
vim.keymap.set({ "i", "s" }, "<S-Tab>", function()
  ls.jump(-1)
end, { silent = true })

-- For changing choices, this also remains the same:
vim.keymap.set({ "i", "s" }, "<C-E>", function()
  if ls.choice_active() then
    ls.change_choice(1)
  end
end, { silent = true })

require("luasnip.loaders.from_lua").load({ paths = "~/.config/nvim/LuaSnip/" })

-- Disable treesitter indentexpr for typst files
vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
  pattern = "*.typ",
  callback = function()
    vim.bo.indentexpr = ""
  end,
})

vim.lsp.enable("julials")
vim.cmd.colorscheme("kanagawa-paper")

vim.keymap.set("n", "<leader>op", function()
  -- Use NeoVim API to get the directory name of
  -- the current buffer
  local path = vim.fs.dirname(vim.api.nvim_buf_get_name(0))
  print(path)
  -- or copy to clipboard:
  vim.fn.setreg("+", path)
end, { desc = "Show/copy current file path" })
