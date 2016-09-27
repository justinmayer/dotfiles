" Vundle ----------------------------------------------------------------------

filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'

" Plugin bundles --------------------------------------------------------------

" User interface
Plugin 'twerth/ir_black'

" Behaviors
Plugin 'mileszs/ack.vim'
Plugin 'matchit.zip'
Plugin 'tpope/vim-commentary'
Plugin 'bronson/vim-trailing-whitespace'

" Language syntax
Plugin 'pearofducks/ansible-vim'
Plugin 'ekalinin/Dockerfile.vim'
Plugin 'dag/vim-fish'
Plugin 'mitsuhiko/vim-jinja'
Plugin 'mutewinter/nginx.vim'
Plugin 'raimon49/requirements.txt.vim'

" Code checking and formatting
Plugin 'editorconfig/editorconfig-vim'
Plugin 'fisadev/vim-isort'

call vundle#end()
