-- Encoding configuration.
vim.opt.encoding = "utf-8"
vim.opt.fileencoding = "utf-8"
vim.opt.fileencodings = { "utf-8" }

-- Avoid constant switching between keyboard layouts.
-- https://stackoverflow.com/questions/3776728/how-to-avoid-constant-switching-to-and-from-english-keyboard-layout-to-type-vim
vim.opt.keymap = "russian-jcuken"
vim.opt.iminsert = 0
vim.opt.imsearch = -1

-- Allow backspacing over everything in insert mode.
vim.opt.backspace = { "indent", "eol", "start" }

-- Do incremental searching when it's possible to timeout.
vim.opt.incsearch = true
vim.opt.hlsearch = true

-- During searching, take the case into the account when using capital letters.
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Disable error bell sound.
vim.opt.errorbells = false
vim.opt.visualbell = false
vim.opt.belloff = "all"

-- Add vertical line denoting 80 symbols border.
vim.opt.colorcolumn = { 80 }

-- Give some space around the cursor in both directions.
vim.opt.scrolloff = 999
vim.opt.sidescrolloff = 5

-- Enable current line highlighting.
vim.opt.cursorline = true

-- Enable line numbers.
vim.opt.number = true
vim.opt.relativenumber = true

-- Tabs and indenting.
-- Maybe use 'tpope/vim-sleuth' instead?
vim.opt.autoindent = true
vim.opt.smartindent = false
vim.opt.smarttab = true
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.softtabstop = 0

-- Disable backups and swapfile, use persistent undo instead.
vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.swapfile = false
vim.opt.undofile = true
vim.opt.undodir = { vim.fn.expand("$HOME/.cache/nvim/undo") }

-- Don't unload a buffer when no longer shown in a window.
vim.opt.hidden = true

-- Disable --[NORMAL/INSERT/VISUAL]-- because lualine already displays it.
vim.opt.showmode = false

-- Always have status line visible.
vim.opt.laststatus = 2

-- Better splits.
vim.opt.splitbelow = true
vim.opt.splitright = true

-- Automatically read a file when it was modified outside of Vim.
vim.opt.autoread = true

-- Better display of non-printable characters.
vim.opt.list = true
vim.opt.listchars = {
  tab = "» ",
  space = "·",
  extends = "›",
  precedes = "‹",
  nbsp = "␣",
}

-- Enable True Color support if possible.
vim.opt.termguicolors = true

-- Sync clipboard between OS and Neovim.
--  Schedule the setting after `UiEnter` because it can increase startup-time.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.schedule(function()
  vim.opt.clipboard = { "unnamed", "unnamedplus" }
end)

-- Decrease mapped sequence wait time.
-- Displays which-key popup sooner.
vim.opt.timeoutlen = 300

-- Decrease update time.
vim.opt.updatetime = 250

-- Keep signcolumn on by default.
vim.opt.signcolumn = "yes"

-- Hide tilda symbol (~) in the end of a buffer.
vim.opt.fillchars = {
  eob = " ",
}

-- Make help window to appear vertically.
-- In Vim, help windows always split horizontally and there is no configuration
-- option to make them split vertically.
vim.api.nvim_create_autocmd({ "BufEnter" }, {
  desc = "Make a help window to appear vertically",
  pattern = "*.txt",
  group = vim.api.nvim_create_augroup("vimrc_help", { clear = true }),
  command = "if &buftype == 'help' | wincmd L | endif",
})

-- Highlight when yanking (copying) text.
-- See `:help vim.highlight.on_yank()`.
vim.api.nvim_create_autocmd({ "TextYankPost" }, {
  desc = "Highlight when yanking (copying) text",
  group = vim.api.nvim_create_augroup("highlight_yank", { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})
