return {
  "oonamo/ef-themes.nvim",
  config = function()
    require("ef-themes").setup({
      on_highlights = function(highlights, colors, name)
        return {
          lualine_c_normal = { bg = "NONE" },
          lualine_c_inactive = { bg = "NONE" },
        }
      end,
    })
  end,
}
