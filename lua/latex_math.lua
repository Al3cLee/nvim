local M = {}

function M.in_latex_math()
  return vim.fn["vimtex#syntax#in_mathzone"]() == 1
end

return M
