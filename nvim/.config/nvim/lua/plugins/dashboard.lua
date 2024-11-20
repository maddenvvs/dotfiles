local function open_folder(path)
  return function()
    vim.cmd.cd(path)
    require("neo-tree.command").execute({
      action = "focus",
    })
  end
end

return {
  "nvimdev/dashboard-nvim",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  event = "VimEnter",
  opts = {
    theme = "hyper",
    shortcut_type = "letter",
    shuffle_letter = false,
    hide = {
      statusline = true,
      tabline = true,
      winbar = true,
    },
    config = {
      disable_move = true,
      week_header = { enable = true },
      packages = { enable = true },
      shortcut = {
        {
          desc = "Dotfiles ",
          key = "d",
          action = open_folder("$DOTFILES"),
        },
        {
          desc = "Orgs ",
          key = "o",
          action = open_folder("$HOME/orgs"),
        },
        {
          desc = "Lazy ",
          key = "l",
          action = "Lazy",
        },
      },
    },
  },
}
