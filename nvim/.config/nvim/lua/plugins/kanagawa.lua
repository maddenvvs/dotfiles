return {
  "rebelot/kanagawa.nvim",
  lazy = false,
  priotiry = 1000,
  config = function()
    local kg = require("kanagawa")

    kg.setup({
      colors = {
        theme = {
          all = {
            ui = {
              -- Remove gutter background.
              -- https://github.com/rebelot/kanagawa.nvim?tab=readme-ov-file#remove-gutter-background
              bg_gutter = "none",
            },
          },
        },
      },
      overrides = function(colors)
        return {
          IblScope = {
            -- Slightly brighter scope bars in `ibl` plugin.
            fg = colors.theme.ui.special,
          },
        }
      end,
    })

    kg.load("wave")
  end,
}
