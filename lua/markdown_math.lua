local M = {}

local function current_node()
  return vim.treesitter.get_node({ ignore_injections = false })
end

function M.in_latex_text()
  local node = current_node()

  while node do
    if node:type() == "text_mode" then
      return true
    else
      node = node:parent()
    end
  end

  return false
end

function M.in_markdown_math()
  -- Make sure we're operating on a `markdown` file.
  local bufnr = vim.api.nvim_get_current_buf()
  if vim.bo[bufnr].filetype ~= "markdown" then
    return false
  end
  -- Get current position and check for injected parsers.
  local pos = vim.api.nvim_win_get_cursor(0)
  local row, col = pos[1] - 1, pos[2]
  local ok, parser = pcall(vim.treesitter.get_parser, bufnr)
  if not ok or not parser then
    return false
  end
  -- Check all language trees at cursor position.
  -- matches: "latex", "equation", "formula", etc.
  local lang_tree = parser:language_for_range({ row, col, row, col })
  if lang_tree then
    local lang = lang_tree:lang()
    if M.in_latex_text() == false and lang:find("latex") then
      return true
    end
  end
  return false
end

function M.not_in_markdown_math()
  return not M.in_markdown_math()
end

return M
