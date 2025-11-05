return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "typst",
        "julia",
      },
      -- Remove the indent disable for typst
    },
  },
}
