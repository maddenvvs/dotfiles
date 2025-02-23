-- Set the leader key.
vim.g.mapleader = " "

-- Set the local leader key.
vim.g.maplocalleader = " "

-- Move between windows using <Ctrl>+[hjkl] keys.
vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Go to left window", silent = true, remap = true })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Go to lower window", silent = true, remap = true })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Go to upper window", silent = true, remap = true })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Go to right window", silent = true, remap = true })

-- Save current buffer without leaving the current mode.
vim.keymap.set({ "i", "n", "v" }, "<C-S>", "<Cmd>write<CR>", { desc = "Save buffer", silent = true })

-- Maintain Visual Mode after shifting > and <.
vim.keymap.set("x", "<", "<gv", { desc = "Shift left (stay visual)", silent = true })
vim.keymap.set("x", ">", ">gv", { desc = "Shift right (stay visual)", silent = true })

-- Move visual blocks down and up.
vim.keymap.set("x", "J", ":m '>+1<CR>gv=gv", { desc = "Move down (stay visual)", silent = true })
vim.keymap.set("x", "K", ":m '<-2<CR>gv=gv", { desc = "Move up (stay visual)", silent = true })

-- Clear search, diff update and redraw.
-- taken from runtime/lua/_editor.lua
-- Previous version:
-- vim.keymap.set("n", "<C-L>", ":nohlsearch<C-R>=has('diff')?'<Bar>diffupdate':''<CR><CR><C-L>", { silent = true })
vim.keymap.set(
  "n",
  "<Leader>ul",
  "<Cmd>nohlsearch<Bar>diffupdate<Bar>normal! <C-L><CR>",
  { desc = "Redraw / Clear hlsearch / Diff Update", silent = true }
)

-- Toggle showing unprintable characters.
vim.keymap.set("n", "<Leader>us", "<Cmd>set list!<CR>", { desc = "show/hide [s]paces" })

-- Neovim already redefined the following. See ':help default-mappings'.

-- Make Y behave like C and D (do operation from the cursor to the end of line).
-- vim.keymap.set("n", "Y", "y$", { silent = true })
