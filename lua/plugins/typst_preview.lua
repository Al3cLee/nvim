return {
  "chomosuke/typst-preview.nvim",
  lazy = false, -- or ft = 'typst'
  version = "1.*",
  opts = {
    -- Point this plugin to the `tinymist` version installed via `Mason`
    -- to avoid version conflicts.
    dependencies_bin = { ["tinymist"] = "tinymist" },
    open_cmd = "open -a Safari %s",
  }, -- lazy.nvim will implicitly calls `setup {}`
}
