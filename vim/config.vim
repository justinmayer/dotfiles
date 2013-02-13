" Basic options ----------------------------------------------------------------

syntax on
set encoding=utf-8
set visualbell t_vb=      " Turn off bell: most annoying default ever created

" User interface ---------------------------------------------------------------

set background=dark
if filereadable(expand("~/.vim/bundle/ir_black/colors/ir_black.vim"))
    colorscheme ir_black
endif

" Tabs and spaces --------------------------------------------------------------

set shiftwidth=4          " Spaces to use for each indent step (>>, <<, etc.)
set softtabstop=4         " Spaces to use for <tab> and <BS> editing operations
set expandtab             " Use appropriate # of spaces for <tab> in insert mode
