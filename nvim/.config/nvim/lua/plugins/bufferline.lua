return {
  "akinsho/bufferline.nvim",
  lazy = false,
  keys = {
    { "<Leader>bo", "<Cmd>BufferLineCloseOthers<CR>", desc = "Close [o]ther buffers" },
    { "[b", "<Cmd>BufferLineCyclePrev<CR>", desc = "Prev Buffer" },
    { "]b", "<Cmd>BufferLineCycleNext<CR>", desc = "Next Buffer" },
    { "<S-h>", "<Cmd>BufferLineCyclePrev<CR>", desc = "Prev Buffer" },
    { "<S-l>", "<Cmd>BufferLineCycleNext<CR>", desc = "Next Buffer" },
  },
  opts = {
    options = {
      diagnostics = "nvim_lsp",
      offsets = {
        {
          filetype = "neo-tree",
          text = "Neo-tree",
          text_align = "center",
          separator = false,
        },
      },
      show_buffer_close_icons = false,
      hover = { enabled = false },
    },
  },
}
