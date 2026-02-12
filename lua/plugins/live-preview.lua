return {
  "brianhuster/live-preview.nvim",
  dependencies = {
    -- You can choose one of the following pickers
    -- 'nvim-telescope/telescope.nvim',
    -- 'ibhagwan/fzf-lua',
    -- 'echasnovski/mini.pick',
    "folke/snacks.nvim",
  },
  require("livepreview.config").set({
    port = 2020,
    browser = "default",
    dynamic_root = true,
    sync_scroll = true,
    picker = "snacks.picker",
    address = "127.0.0.1",
  }),
}
