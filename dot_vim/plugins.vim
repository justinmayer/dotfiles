set laststatus=2   " Always show the statusline in all windows
set showtabline=2  " Always display the tabline, even if there is only one tab
set noshowmode " Hide default mode text, e.g. -- INSERT -- below the statusline

" ack.vim: use ripgrep/ag if available ----------------------------------------

if executable('rg')
    let g:ackprg = 'rg -S --no-heading --vimgrep'
elseif executable('ag')
    let g:ackprg = 'ag --vimgrep'
endif

" Asynchronous Lint Engine (ALE)
let g:airline#extensions#ale#enabled = 1

" vim-airline
let g:airline_powerline_fonts = 1

" Prose-related plugins
augroup prose
    autocmd!
    autocmd FileType markdown,mkd call pencil#init({'wrap': 'soft'})
                              \ | call lexical#init()
                              \ | call litecorrect#init()
                              \ | call textobj#quote#init()
                              \ | call textobj#sentence#init()
augroup END

" vim-startify
let g:startify_session_persistence = 1  " Auto-save session when Vim quits

" YouCompleteMe
let g:ycm_enable_semantic_highlighting=1
