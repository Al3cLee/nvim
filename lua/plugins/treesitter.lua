return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "typst",
        "julia",
        "markdown",
        "markdown_inline",
      },
      -- Remove the indent disable for typst
    },
  },
}
