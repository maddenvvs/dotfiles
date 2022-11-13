"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Options
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" During searching, take case into the account when using capital letters.
set ignorecase smartcase

" Disable error bell sound.
set belloff=all

" Add vertcat line denoting 80 symbols border.
set colorcolumn=80

" Enable current line highlighting. Disabling horizontal cursor line can
" improve possible issues as it is very slow over ssh.
" https://stackoverflow.com/q/307148/1745064
set cursorline

" Enable line numbers.
set number relativenumber

" Smart autoindent when starting a new line.
set smartindent

" Disable backups and swapfile, use persistent undo instead.
set noswapfile nobackup nowritebackup

" Enable persistent undo.
if has('persistent_undo')
  set undofile undodir=~/.cache/vim/undo
  call mkdir(&undodir, "p", 0700)
endif

" Shorter update time than the 4000ms default, for async vim operations.
set updatetime=2000

" Disable --INSERT-- which is not necessary, because vim-airline already
" displays it.
set noshowmode

" Better splits.
set splitbelow splitright

" Automatically write current working buffer when leaving it (on exit or on
" edit of a new file).
set autowriteall

" Better display of special characters.
set list listchars=tab:»\ ,space:·,extends:›,precedes:‹,nbsp:␣


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Key bindings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Set leader key. Default is '\'.
let mapleader="\<Space>"

" Set local leader key.
let maplocalleader="\<Space>l"

" Make Y behave like C and D (do operation from the cursor to the end of line).
nnoremap Y y$

" Save a buffer both in NORMAL in INSERT modes.
inoremap <C-s>     <C-O>:update<cr>
nnoremap <C-s>     :update<cr>
nnoremap <leader>w :update<cr>

" Comment/uncomment using tpope/commentary plugin.
noremap <leader>/ :Commentary<cr>

" Tab key mappings.
nnoremap <leader>tt :$tabnew<cr>
nnoremap <leader>tw :windo bdelete<cr>
nnoremap <leader><Tab> :tabnext<cr>
nnoremap <leader><S-Tab> :tabprevious<cr>
nnoremap <leader>>> :+tabmove<cr>
nnoremap <leader><< :-tabmove<cr>

" Ctrl-P behaviour like in VS Code.
" The displayed filelist depends on $FZF_DEFAULT_COMMAND environment variable
" defined in zsh configuration files.
nnoremap <leader>p :Files<cr>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Misc
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Make :h and :help to open in a new tab instead of a new split window.
" Taken from here: https://stackoverflow.com/a/3132202
cnoreabbrev <expr> h
  \ getcmdtype() == ":" && getcmdline() == 'h' ? 'tab help' : 'h'
cnoreabbrev <expr> help
  \ getcmdtype() == ":" && getcmdline() == 'help' ? 'tab help' : 'help'


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Gruvbox
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function ConfigureGruvboxTheme()
  " Enable True Color support if possible.
  if (has("termguicolors"))
    set termguicolors
  endif

  " Use dark theme.
  set background=dark
  let g:gruvbox_contrast_dark = 'medium'

  " Enforce italic usage on terminals.
  let g:gruvbox_italic = 1

  " Enable Gruvbox theme.
  colorscheme gruvbox
endfunction

" Vim always reads .vimrc file first and after that starts to load plugins. We
" use autocmd VimEnter to make sure that all plugins are loaded completely and
" then use gruvbox. ++nested is used to allow automatic filetype detection.
autocmd VimEnter * ++nested call ConfigureGruvboxTheme()


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Airline
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Automatically populate the g:airline_symbols dictionary with the powerline
" symbols.
let g:airline_powerline_fonts = 1

" Automatically displays all buffers when there's only one tab open.
let g:airline#extensions#tabline#enabled = 1


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Fzf
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" For fzf preview window, pressing enter opens a file in a separate tab instead
" of the current one.
let g:fzf_action = { 'enter': 'tab split' }


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Kitty terminal
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Vim uses background color erase when Vim theme declares background color.
" Kitty terminal emulator doesn't support background color erase which leads
" to incorrect displaying of background color when scrolling. The following
" line effectively fixes the issue. For more information please see:
" https://sw.kovidgoyal.net/kitty/faq/#using-a-color-theme-with-a-background-color-does-not-work-well-in-vim
let &t_ut=''

" Change the cursor in different modes.
" Normal - block, Insert - bar, Replace - underline.
let &t_SI = "\e[5 q"
let &t_SR = "\e[3 q"
let &t_EI = "\e[2 q"

