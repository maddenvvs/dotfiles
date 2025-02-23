-- Shows short name of currently active keymap. See ':h keymap'.
-- https://github.com/nvim-lualine/lualine.nvim/wiki/Component-snippets#keymap
local function keymap()
  if vim.opt.iminsert:get() > 0 and vim.b.keymap_name then
    return "⌨ " .. vim.b.keymap_name
  end
  return ""
end

return {
  "nvim-lualine/lualine.nvim",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  opts = {
    options = {
      globalstatus = true,
    },
    sections = {
      lualine_c = { "filename", keymap },
    },
    extensions = {
      "neo-tree",
      "lazy",
    },
  },
}
