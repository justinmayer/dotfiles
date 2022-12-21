" Vim-Plug --------------------------------------------------------------------

" Plugins will be installed into the specified directory.
call plug#begin(has('nvim') ? stdpath('data') . '/plugged' : '~/.vim/plugged')

" Plugins ---------------------------------------------------------------------

" User interface
Plug 'twerth/ir_black'
Plug 'vim-airline/vim-airline'

" Behaviors
Plug 'mileszs/ack.vim'
Plug 'chrisbra/matchit'
Plug 'tpope/vim-commentary'
Plug 'bronson/vim-trailing-whitespace'

" Syntax highlighting
Plug 'alker0/chezmoi.vim'
Plug 'pearofducks/ansible-vim'
Plug 'ekalinin/Dockerfile.vim'
Plug 'dag/vim-fish'
Plug 'mitsuhiko/vim-jinja'
Plug 'mutewinter/nginx.vim'
Plug 'raimon49/requirements.txt.vim'

" Code checking and formatting
Plug 'editorconfig/editorconfig-vim'
if has('python')
Plug 'fisadev/vim-isort'
endif

call plug#end()
