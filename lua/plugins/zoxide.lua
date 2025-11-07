return {
  "alfaix/nvim-zoxide",
  dependencies = { "nvim-lua/plenary.nvim" },
  opts = {
    -- will define Z[!], Zt[!], Zw[!] for :cd, :tcd, :lcd respectively
    -- set to false if you want to define different ones
    define_commands = true,
    -- path to zoxide executable; by default must be in $PATH
    path = "/opt/homebrew/bin/zoxide",
  },
}
