return {
  "nvim-telescope/telescope.nvim",
  cmd = "Telescope",
  keys = {
    { "<Leader>ff", "<Cmd>Telescope find_files<CR>", desc = "[f]ind files" },
    { "<Leader>uc", "<Cmd>Telescope colorscheme enable_preview=true<CR>", desc = "[c]hange colorscheme" },
    { "<Leader>/", "<Cmd>Telescope live_grep<CR>", desc = "grep cwd" },
    { "<Leader>gs", "<cmd>Telescope git_status<CR>", desc = "git [s]tatus" },
    { "<leader>sh", "<cmd>Telescope help_tags<cr>", desc = "[h]elp pages" },
  },
  config = function()
    local telescope = require("telescope")
    local telescopeConfig = require("telescope.config")

    -- Clone the default Telescope configuration
    local vimgrep_arguments = { unpack(telescopeConfig.values.vimgrep_arguments) }

    -- I want to search in hidden/dot files.
    table.insert(vimgrep_arguments, "--hidden")
    -- I don't want to search in the `.git` directory.
    table.insert(vimgrep_arguments, "--glob")
    table.insert(vimgrep_arguments, "!**/.git/*")

    telescope.setup({
      defaults = {
        -- file_ignore_patterns = {
        --   ".git/",
        -- },
        -- `hidden = true` is not supported in text grep commands.
        vimgrep_arguments = vimgrep_arguments,
      },
      pickers = {
        find_files = {
          -- `hidden = true` will still show the inside of `.git/` as it's not `.gitignore`d.
          find_command = { "rg", "--files", "--no-ignore", "--hidden", "--glob", "!**/.git/*" },
        },
      },
    })
  end,
}
