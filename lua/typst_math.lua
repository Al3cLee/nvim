local M = {}

function M.in_typst_math()
  -- Make sure we're operating on a `typst` file.
  local bufnr = vim.api.nvim_get_current_buf()
  if vim.bo[bufnr].filetype ~= "typst" then
    return false
  end
  -- Get the node at the cursor, loop til its root and look for
  -- any node type containing "math".
  local node = vim.treesitter.get_node()
  while node do
    -- Visit each node and
    -- check whether "string" or "math" appears.
    -- If neither appears,
    -- go up the syntax tree.
    local t = node:type()
    -- Exit math mode if inside string,
    -- useful for annotations inside formulae,
    -- e.g. $x = 0 "assuming" y<0$.
    if t:find("string") then
      return false
    elseif t and t:find("math") then
      -- Declare math mode if node type contains math.
      return true
    else
      node = node:parent()
    end
  end
  -- Provide default value `false` for the function.
  return false -- This line must be outside the while loop.
end

function M.not_in_typst_math()
  return not M.in_typst_math()
end

return M
