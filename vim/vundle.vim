" Vundle ----------------------------------------------------------------------

filetype off
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

Bundle 'gmarik/vundle'

" Plugin bundles --------------------------------------------------------------

" User interface
Bundle 'twerth/ir_black'

" Behaviors
Bundle 'tpope/vim-commentary'

" Language syntax
Bundle 'ekalinin/Dockerfile.vim'
Bundle 'dag/vim-fish'
Bundle 'mitsuhiko/vim-jinja'
Bundle 'mutewinter/nginx.vim'

" Code checking and formatting
Bundle 'fisadev/vim-isort'
