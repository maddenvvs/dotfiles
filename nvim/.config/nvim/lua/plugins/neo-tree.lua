return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "MunifTanjim/nui.nvim",
    -- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
  },
  cmd = "Neotree",
  keys = {
    {
      "<Leader>fe",
      ":Neotree left toggle reveal<CR>",
      desc = "[f]ile [e]xplorer",
      mode = "n",
      silent = true,
    },
    {
      "<Leader>e",
      "<Leader>fe",
      desc = "[f]ile [e]xplorer",
      mode = "n",
      remap = true,
      silent = true,
    },
    {
      "<Leader>be",
      ":Neotree left toggle buffers<CR>",
      desc = "[b]uffer [e]xplorer",
      mode = "n",
      silent = true,
    },
    {
      "<Leader>ge",
      ":Neotree left toggle git_status<CR>",
      desc = "[g]it status [e]xplorer",
      mode = "n",
      silent = true,
    },
  },
  opts = {
    filesystem = {
      filtered_items = {
        visible = true,
      },
    },
    window = {
      mappings = {
        -- Prevent mapping collision with existing <Leader> mappings.
        ["<space>"] = "none",
      },
    },
    -- Fix issue with black borders/black color.
    -- https://github.com/nvim-neo-tree/neo-tree.nvim/issues/1480#issuecomment-2127093906
    popup_border_style = "single",
  },
}
