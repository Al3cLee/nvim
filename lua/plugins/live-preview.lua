return {
  "Al3cLee/live-preview.nvim",
  branch = "main",
  dependencies = {
    -- You can choose one of the following pickers
    -- 'nvim-telescope/telescope.nvim',
    -- 'ibhagwan/fzf-lua',
    -- 'echasnovski/mini.pick',
    "folke/snacks.nvim",
  },
  config = function()
    require("livepreview.config").set({
      port = 5500,
      browser = "default",
      dynamic_root = true,
      sync_scroll = true,
      -- picker = "snacks",
      address = "127.0.0.1",
    })
  end,
}
