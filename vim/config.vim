" Basic options ----------------------------------------------------------------

syntax on
set encoding=utf-8
set visualbell t_vb=      " Turn off bell: most annoying default ever created

if &shell =~# 'fish$'     " If Fish is default shell, tell Vim to use Bash.
    set shell=/bin/bash   " Otherwise, Vundle and other tools will malfunction.
endif

" User interface ---------------------------------------------------------------

set background=dark
if (has("termguicolors"))
    set termguicolors
endif
if filereadable(expand("~/.vim/bundle/ir_black/colors/ir_black.vim"))
    colorscheme ir_black
endif

" Behaviors --------------------------------------------------------------------

set showcmd               " In Visual mode, show selected characters, lines, etc
set wildmenu              " Turn on menu-based tab completion for commands
set autoread              " Read file if it has changed outside of Vim
set splitbelow splitright " More intuitive than default split behavior
set nobackup              " Modern systems have better ways to back up files
set noswapfile            " Not much need for swapfiles in the 21st century
set nojoinspaces          " Use only one space after period when joining lines

" Tabs and spaces --------------------------------------------------------------

set shiftwidth=4          " Spaces to use for each indent step (>>, <<, etc.)
set shiftround            " Round indent to multiple of shiftwidth
set softtabstop=4         " Spaces to use for <tab> and <BS> editing operations
set expandtab             " Use appropriate # of spaces for <tab> in insert mode

" Indents and wrapping ---------------------------------------------------------

set linebreak             " Soft-wrap at word instead of character
set autoindent            " Copy indent from current line when starting new line
set bs=indent,eol,start   " Backspace over autoindent, EOL, and start of insert

" Searching --------------------------------------------------------------------

set ignorecase            " Case-insensitive search
set smartcase             " Case-sensitive search if query contains uppercase
set incsearch             " Show first search result as query is typed

" Visual -----------------------------------------------------------------------

set cursorline            " Highlight the line the cursor is on
set showmatch             " Briefly jump to matching bracket when inserted
