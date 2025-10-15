-- Get user's home directory for config path resolution
local HOME = os.getenv("HOME")

return {
  -- nvim-lint: Asynchronous linting plugin for Neovim
  "mfussenegger/nvim-lint",
  optional = true,
  -- The `config` item is documented in the docs of
  -- Lazy.nvim instead of LazyVim, see https://lazy.folke.io/spec#spec-setup
  config = function()
    -- Configure markdownlint-cli2 to use custom config file
    -- located in Neovim's config directory
    -- with syntax inspired by https://github.com/mfussenegger/nvim-lint#customize-built-in-linters
    require("lint").linters["markdownlint-cli2"].args = {
      "--config",
      -- For how to write config files see https://github.com/DavidAnson/markdownlint-cli2#configuration
      HOME .. "/.config/nvim/.markdownlint-cli2.yaml",
      -- The following `--` indicates that stuff before it are options, not args
      "--",
    }
  end,
}
