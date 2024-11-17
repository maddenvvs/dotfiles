return {
  'lewis6991/gitsigns.nvim',
  opts = {
    signs = {
      add = { text = "▎" },
      change = { text = "▎" },
      delete = { text = "" },
      topdelete = { text = "" },
      changedelete = { text = "▎" },
      untracked = { text = "▎" },
    },
    signs_staged = {
      add = { text = "▎" },
      change = { text = "▎" },
      delete = { text = "" },
      topdelete = { text = "" },
      changedelete = { text = "▎" },
    },
    on_attach = function(buffer)
      local gs = require('gitsigns')

      local function map(mode, l, r, desc)
        vim.keymap.set(mode, l, r, { buffer = buffer, desc = desc })
      end

      map("n", "]c", function()
        if vim.wo.diff then
          vim.cmd.normal({ "]c", bang = true })
        else
          gs.nav_hunk("next")
        end
      end, "next [c]hange")

      map("n", "[c", function()
        if vim.wo.diff then
          vim.cmd.normal({ "[c", bang = true })
        else
          gs.nav_hunk("prev")
        end
      end, "previous [c]hange")

      map("n", "]C", function() gs.nav_hunk("last") end, "last [C]hange")
      map("n", "[C", function() gs.nav_hunk("first") end, "first [C]hange")
      map({ "n", "v" }, "<leader>hs", ":Gitsigns stage_hunk<CR>", "[h]unk [s]tage")
      map({ "n", "v" }, "<leader>hr", ":Gitsigns reset_hunk<CR>", "[h]unk [r]eset")
      map("n", "<leader>hS", gs.stage_buffer, "[S]tage buffer")
      map("n", "<leader>hu", gs.undo_stage_hunk, "[h]unk [u]ndo stage")
      map("n", "<leader>hR", gs.reset_buffer, "[R]eset buffer")
      map("n", "<leader>hp", gs.preview_hunk_inline, "[h]unk [p]review")
      map("n", "<leader>hb", function() gs.blame_line({ full = true }) end, "[b]lame line")
      map("n", "<leader>hB", function() gs.blame() end, "[B]lame buffer")
      map("n", "<leader>hd", gs.diffthis, "[d]iff against index")
      map("n", "<leader>hD", function() gs.diffthis("~") end, "[D]iff against last commit")

      -- map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", "GitSigns Select Hunk")
    end,
  },
}

