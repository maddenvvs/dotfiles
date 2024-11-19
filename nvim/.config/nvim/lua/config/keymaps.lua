-- Set leader key.
vim.g.mapleader = " "

-- Set local leader key.
vim.g.maplocalleader = " "

-- Save a buffer both in without leaving the current mode.
vim.keymap.set({ "i", "n", "v" }, "<C-S>", "<Cmd>write<CR>", { silent = true, desc = "Save buffer" })

-- Maintain Visual Mode after shifting > and <.
vim.keymap.set("x", "<", "<gv", { silent = true, desc = "Shift left (stay visual)" })
vim.keymap.set("x", ">", ">gv", { silent = true, desc = "Shift right (stay visual)" })

-- Move visual blocks down and up.
vim.keymap.set("x", "J", ":m '>+1<CR>gv=gv", { silent = true, desc = "Move down (stay visual)" })
vim.keymap.set("x", "K", ":m '<-2<CR>gv=gv", { silent = true, desc = "Move up (stay visual)" })

-- Nvim already redefines them the way below. There is no need to difine them again.
-- See ':help default-mappings'.

-- Make Y behave like C and D (do operation from the cursor to the end of line).
-- vim.keymap.set("n", "Y", "y$", { silent = true })

-- Clear the highlighting of ':set hlsearch'.
-- vim.keymap.set("n", "<C-L>", ":nohlsearch<C-R>=has('diff')?'<Bar>diffupdate':''<CR><CR><C-L>", { silent = true })
