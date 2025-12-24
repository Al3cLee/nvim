return {
  "oonamo/ef-themes.nvim",
  config = function()
    require("ef-themes").setup({
      -- See https://github.com/oonamo/ef-themes.nvim/tree/main?tab=readme-ov-file#configuration for the config below
      on_highlights = function(highlights, colors, name)
        return {
          lualine_c_normal = { bg = "NONE" },
          lualine_c_inactive = { bg = "NONE" },
        }
      end,
    })
  end,
}
