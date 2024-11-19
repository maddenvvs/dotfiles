return {
  "rebelot/kanagawa.nvim",
  lazy = false,
  priotiry = 1000,
  config = function()
    require("kanagawa").load("wave")
  end,
}
