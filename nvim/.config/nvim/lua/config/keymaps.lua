-- Set leader key. Default is '\'.
vim.g.mapleader = " "

-- Set local leader key.
vim.g.maplocalleader = vim.g.mapleader .. "l"

-- Make Y behave like C and D (do operation from the cursor to the end of line).
vim.keymap.set("n", "Y", "y$", { silent = true })

-- Save a buffer both in NORMAL in INSERT modes.
vim.keymap.set("i", "<C-S>", "<C-O>:update<CR>", { silent = true })
vim.keymap.set("n", "<C-S>", ":update<CR>", { silent = true })

-- Maintain Visual Mode after shifting > and <.
vim.keymap.set("x", "<", "<gv", { silent = true })
vim.keymap.set("x", ">", ">gv", { silent = true })

-- Move visual blocks down and up.
vim.keymap.set("x", "J", ":m '>+1<CR>gv=gv", { silent = true })
vim.keymap.set("x", "K", ":m '<-2<CR>gv=gv", { silent = true })

-- Clear the highlighting of ':set hlsearch'.
vim.keymap.set("n", "<C-L>", ":nohlsearch<C-R>=has('diff')?'<Bar>diffupdate':''<CR><CR><C-L>", { silent = true })

-- Remap default keyboard layout change mapping to more confortable.
-- See ':h keymap'.
vim.keymap.set("i", "<C-\\>", "<C-^>", { silent = true })
