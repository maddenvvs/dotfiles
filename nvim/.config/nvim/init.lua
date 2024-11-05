-- This initialization was taken from ':h nvim' to reuse the existing Vim
-- configuration.
vim.api.nvim_command('set runtimepath^=~/.vim runtimepath+=~/.vim/after')
vim.api.nvim_command('let &packpath = &runtimepath')
vim.api.nvim_command('source ~/.vim/vimrc')

-- nvim-orgmode configuration.
-- https://github.com/nvim-orgmode/orgmode/blob/master/DOCS.md
require('orgmode').setup({
  org_agenda_files = {
    '~/orgs/**/*',
  },
  win_split_mode = 'vertical',
})

