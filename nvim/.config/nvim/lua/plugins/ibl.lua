return {
  "lukas-reineke/indent-blankline.nvim",
  main = "ibl",
  opts = {
    indent = {
      char = "│",
      tab_char = "│",
    },
    scope = {
      char = "▍",
      show_start = false,
      show_end = false,
      include = {
        node_type = {
          lua = {
            "return_statement",
            "table_constructor",
          },
        },
      },
    },
    exclude = {
      filetypes = {
        "dashboard",
        "help",
        "neo-tree",
      },
    },
  },
}
