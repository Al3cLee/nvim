return {
  {
    "Zeta611/tex2uni.nvim",
    enabled = true,
    opts = {
      ft = { "*.{tex,jl,v,md,csv,typ}" }, -- enable for specific filetypes
      abbreviations = {
        extra = {
          ["pure"] = "⌜$CURSOR⌝", -- add custom abbreviations
        },
      },
    },
  },
}
