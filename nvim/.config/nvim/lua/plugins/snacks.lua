return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  keys = {
    {
      "<Leader>bd",
      function()
        Snacks.bufdelete.delete()
      end,
      desc = "[d]elete buffer",
      silent = true,
    },
  },
  opts = {
    bufdelete = { enabled = true },
    notifier = { enabled = true },
    dashboard = {
      preset = {
        keys = {
          { icon = " ", key = "f", desc = "Find File", action = ":lua Snacks.dashboard.pick('files')" },
          { icon = " ", key = "g", desc = "Find Text", action = ":lua Snacks.dashboard.pick('live_grep')" },
          {
            icon = " ",
            key = "d",
            desc = "Dotfiles",
            action = ":lua Snacks.dashboard.pick('files', {cwd = '$DOTFILES'})",
          },
          {
            icon = " ",
            key = "o",
            desc = "Orgfiles",
            action = ":lua Snacks.dashboard.pick('files', {cwd = '$HOME/orgs'})",
          },
          { icon = "󰒲 ", key = "L", desc = "Lazy", action = ":Lazy", enabled = package.loaded.lazy ~= nil },
          { icon = " ", key = "q", desc = "Quit", action = ":qa" },
        },
      },
      formats = {
        key = function(item)
          return { { "[", hl = "key" }, { item.key, hl = "key" }, { "]", hl = "key" } }
        end,
      },
    },
  },
}
