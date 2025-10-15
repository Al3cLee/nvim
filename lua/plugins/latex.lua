return {
  -- Ensure this runs after any LaTeX-related plugins that might enable conceal
  {
    "lervag/vimtex", -- This targets the VimTeX plugin
    ft = "tex",
    config = function()
      -- Alternatively, to disable specific parts of conceal (e.g., only math super/subscripts):
      vim.g.vimtex_syntax_conceal = {
        --  accents = 0,
        math_super_sub = 0,
        math_fracs = 0,
        styles = 1,
        -- Keep other conceal features if desired
      }

      -- Also explicitly set Neovim's conceallevel for tex files
      -- This ensures that even if VimTeX doesn't control it, conceal is off.
    end,
  },

  -- If the issue persists or you suspect Tree-sitter, you can disable it for LaTeX.
  -- This is less likely to be the primary cause of *this specific* issue,
  -- but can be a troubleshooting step.
}
