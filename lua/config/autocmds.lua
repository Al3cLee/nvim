-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
  pattern = "*.typ",
  callback = function()
    -- Disable treesitter indentexpr for typst files.
    -- This is required because indentexpr overrides other indent options.
    vim.bo.indentexpr = ""
    -- Enforce autoindent,
    -- but autoindent is on by default anyway.
    vim.bo.autoindent = true
  end,
})

vim.api.nvim_create_user_command("TeXTemplate", function()
  vim.cmd("0r ~/.config/nvim/templates/tex-template.tex")
end, {})

vim.api.nvim_create_user_command("TypstTemplate", function()
  vim.cmd("!cp ~/.config/nvim/templates/typst_templates.typ ./preamble.typ")
  vim.cmd("!cp ~/.config/nvim/templates/preamble_standalone.typ ./preamble_standalone.typ")
end, {})

vim.api.nvim_create_user_command("TypstDoc", function()
  vim.cmd("!cp -R ~/.config/nvim/templates/typst_doc .")
  vim.cmd("!cp ~/.config/nvim/templates/preamble_standalone.typ ./preamble_standalone.typ")
  vim.cmd("!cp ~/.config/nvim/templates/typst_templates.typ ./typst_doc/preamble.typ")
end, {})

vim.api.nvim_create_user_command("TypstTouying", function()
  vim.cmd("!cp -R ~/.config/nvim/templates/typst_touying .")
  vim.cmd("!cp ~/.config/nvim/templates/preamble_standalone.typ ./preamble_standalone.typ")
  vim.cmd("!cp ~/.config/nvim/templates/typst_templates.typ ./typst_touying/preamble.typ")
end, {})

vim.api.nvim_create_user_command("YankAll", function()
  vim.cmd("%y")
end, {})

vim.api.nvim_create_user_command("MarkdownPreview", function()
  vim.cmd("LivePreview close")
  vim.cmd("LivePreview start")
end, {})

vim.api.nvim_create_user_command("MarkdownPreviewStop", function()
  vim.cmd("LivePreview close")
end, {})

vim.keymap.set("n", "<leader>op", function()
  -- Use NeoVim API to get the directory name of
  -- the current buffer
  local path = vim.fs.dirname(vim.api.nvim_buf_get_name(0))
  print(path)
  -- or copy to clipboard:
  vim.fn.setreg("+", path)
end, { desc = "Show/copy current file path" })
