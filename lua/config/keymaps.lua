-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

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
