" Vim-Plug --------------------------------------------------------------------

" Automatically install Vim-Plug
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" Plugins will be installed into the specified directory.
call plug#begin(has('nvim') ? stdpath('data') . '/plugged' : '~/.vim/plugged')

" Plugins ---------------------------------------------------------------------

" User interface
Plug 'twerth/ir_black'
Plug 'vim-airline/vim-airline'
Plug 'mhinz/vim-startify'

" Behaviors
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'chrisbra/matchit'
Plug 'tpope/vim-commentary'
Plug 'preservim/vim-lexical'
Plug 'preservim/vim-litecorrect'
Plug 'preservim/vim-pencil'
Plug 'preservim/vim-textobj-quote'
Plug 'preservim/vim-textobj-sentence'
Plug 'kana/vim-textobj-user'
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
