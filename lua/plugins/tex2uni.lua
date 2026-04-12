return {
  {
    "Zeta611/tex2uni.nvim",
    opts = {
      ft = { "*.{tex,jl,v,md}" }, -- enable for specific filetypes
      abbreviations = {
        extra = {
          ["pure"] = "⌜$CURSOR⌝", -- add custom abbreviations
        },
      },
    },
  },
}
