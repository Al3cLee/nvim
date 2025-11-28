return {
  "stevearc/conform.nvim",
  opts = {
    formatters_by_ft = {
      python = { "black" },
      rust = { "rustfmt" },
    },
    formatters = {
      rustfmt = {
        prepend_args = { "--config", "max_width=70" },
      },
    },
  },
}
