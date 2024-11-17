return {
  'folke/which-key.nvim',
  event = 'VeryLazy',
  keys = {
    {
      "<Leader>?",
      function()
        require("which-key").show({ global = false })
      end,
      desc = "Buffer Local Keymaps (which-key)",
    },
  },
  opts = {
    icons = {
      -- I don't need fancy icons for this plugin.
      mappings = false,
    },
    preset = "helix",
    spec = {
      mode = { 'n', 'v' },
      { '<Leader>h', group = 'git [h]unk' },
      { "[", group = "prev" },
      { "]", group = "next" },
      { "g", group = "goto" },
      { "z", group = "fold" },
    },
  },
}
