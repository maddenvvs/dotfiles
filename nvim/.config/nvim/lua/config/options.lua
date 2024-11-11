-- Encoding configuration.
vim.opt.encoding = 'utf-8'
vim.opt.fileencoding = 'utf-8'
vim.opt.fileencodings = { 'utf-8' }

-- Avoid constant switching between keyboard layouts.
-- https://stackoverflow.com/questions/3776728/how-to-avoid-constant-switching-to-and-from-english-keyboard-layout-to-type-vim
vim.opt.keymap = 'russian-jcuken'
vim.opt.iminsert = 0
vim.opt.imsearch = -1

-- Allow backspacing over everything in insert mode.
vim.opt.backspace = { 'indent', 'eol' , 'start' }

-- Do incremental searching when it's possible to timeout.
vim.opt.incsearch = true
vim.opt.hlsearch = true

-- During searching, take the case into the account when using capital letters.
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Disable error bell sound.
vim.opt.errorbells = false
vim.opt.visualbell = false
vim.opt.belloff = 'all'

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
vim.opt.undodir = { vim.fn.expand('$HOME/.cache/nvim/undo') }

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
  tab = '» ',
  space = '•',
  extends = '›',
  precedes = '‹',
  nbsp = '␣',
}

-- Enable True Color support if possible.
vim.opt.termguicolors = true

-- Use regular clipboard register (* and +) for yank/paste/delete operations.
vim.opt.clipboard = { 'unnamed', 'unnamedplus' }


-- Make help window to appear vertically.
-- In Vim, help windows always split horizontally and there is no configuration
-- option to make them split vertically.
local help_group = vim.api.nvim_create_augroup('vimrc_help', { clear = true })
vim.api.nvim_create_autocmd({ 'BufEnter' }, {
  pattern = '*.txt',
  group = help_group,
  command = "if &buftype == 'help' | wincmd L | endif",
})

