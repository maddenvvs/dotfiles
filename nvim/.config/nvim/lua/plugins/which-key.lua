return {
  "folke/which-key.nvim",
  event = "VeryLazy",
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
      mode = { "n", "v" },
      { "<Leader>h", group = "git [h]unk" },
      { "<Leader>o", group = "[o]rgmode" },
      { "<Leader>u", group = "[u]i" },
      { "<Leader>f", group = "[f]ile/[f]ind" },
      { "<Leader>g", group = "[g]it" },
      { "<leader>s", group = "[s]earch" },
      { "[", group = "prev" },
      { "]", group = "next" },
      { "g", group = "goto" },
      { "z", group = "fold" },
      {
        "<Leader>b",
        group = "[b]uffers",
        expand = function()
          return require("which-key.extras").expand.buf()
        end,
      },
      {
        "<C-w>",
        group = "[w]indows",
        expand = function()
          return require("which-key.extras").expand.win()
        end,
      },
    },
    -- Don't wait for a key to be pressed before showing the popup
    -- (only used by enabled xo mapping modes).
    defer = function()
      return false
    end,
  },
}
