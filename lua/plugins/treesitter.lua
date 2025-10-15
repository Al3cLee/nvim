return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "typst",
      },
      -- Remove the indent disable for typst
    },
  },
}
