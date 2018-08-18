set laststatus=2   " Always show the statusline in all windows
set showtabline=2  " Always display the tabline, even if there is only one tab
set noshowmode " Hide default mode text, e.g. -- INSERT -- below the statusline

" ack.vim: use ripgrep/ag if available ----------------------------------------

if executable('rg')
    let g:ackprg = 'rg -S --no-heading --vimgrep'
elseif executable('ag')
    let g:ackprg = 'ag --vimgrep'
endif

" vim-airline
let g:airline_powerline_fonts = 1
