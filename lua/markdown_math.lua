local M = {}

local function current_node(bufnr, row, col)
  local ok, parser = pcall(vim.treesitter.get_parser, bufnr, "markdown")
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
    if lang and (lang:find("latex") or lang:find("equation") or lang:find("formula")) then
      return true
    end
  end
  -- If no injected language found, check the fenced_code_block info_string
  local node = current_node(bufnr, row, col)
  while node do
    local t = node:type()
    if t == "fenced_code_block" then
      for child in node:iter_children() do
        if child:type() == "info_string" then
          local lang = vim.treesitter.get_node_text(child, bufnr)
          if lang and (lang:find("equation") or lang:find("formula")) then
            return true
          end
        end
      end
    end
    node = node:parent()
  end
  return false
end

function M.not_in_markdown_math()
  return not M.in_markdown_math()
end

return M