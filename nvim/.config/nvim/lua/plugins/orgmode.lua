return {
  "nvim-orgmode/orgmode",
  event = "VeryLazy",
  ft = { "org" },
  opts = {
    org_agenda_files = {
      "~/orgs/**/*",
    },
    win_split_mode = "vertical",
    org_capture_templates = {
      t = {
        description = "Task",
        template = "* TODO %?\n  %u\n",
        target = "~/orgs/tasks.org",
      },
    },
  },
  config = function(_, opts)
    require("orgmode").setup(opts)

    -- NOTE: If you are using nvim-treesitter with ~ensure_installed = "all"~ option
    -- add ~org~ to ignore_install
    -- require('nvim-treesitter.configs').setup({
    --   ensure_installed = 'all',
    --   ignore_install = { 'org' },
    -- })
  end,
}
