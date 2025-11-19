-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")
vim.api.nvim_create_user_command("TypstTemplate", function()
  vim.cmd("0r ~/.config/nvim/templates/note_template.typ")
end, {})
vim.api.nvim_create_user_command("TeXTemplate", function()
  vim.cmd("0r ~/.config/nvim/templates/tex-template.tex")
end, {})
vim.api.nvim_create_user_command("TouyingTemplate", function()
  vim.cmd("0r ~/.config/nvim/templates/touying.typ")
end, {})
