return {
  "stevearc/conform.nvim",
  opts = {
    formatters_by_ft = {
      python = { "black" },
      rust = { "rustfmt" },
    },
    formatters = {
      -- Python: Configure Black
      black = {
        prepend_args = { "--line-length", "70" },
      },
      rustfmt = {
        prepend_args = { "--config", "max_width=70" },
      },
    },
  },
}
