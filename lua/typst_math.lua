local M = {}

local function current_node(bufnr, row, col)
  local ok, parser = pcall(vim.treesitter.get_parser, bufnr, vim.bo[bufnr].filetype)
  if not ok or not parser then
    return nil
  end
  local tree = parser:parse()[1]
  if not tree then
    return nil
  end
  local root = tree:root()
  -- Use the if idiom of Lua to return the narrowest node
  -- if `root` exists and `nil` if it does not, which means
  -- the whole function `current_node` outputs really the current_node.
  return root and root:named_descendant_for_range(row, col, row, col) or nil
end

function M.in_typst_math()
  -- Make sure we're operating on a `typst` file.
  local bufnr = vim.api.nvim_get_current_buf()
  if vim.bo[bufnr].filetype ~= "typst" then
    return false
  end
  -- Get current_node, loop til its root and look for
  -- any node type containing "math".
  local pos = vim.api.nvim_win_get_cursor(0)
  local row, col = pos[1] - 1, pos[2]
  local node = current_node(bufnr, row, col)
  while node do
    local t = node:type()
    -- matches: "math", "math_block", "inline_math", etc.
    if t and t:find("math") then
      return true
    end
    node = node:parent()
  end
  return false
end

function M.not_in_typst_math()
  return not M.in_typst_math()
end

return M
