" Directional keys ------------------------------------------------------------

" When wrapping is on, move cursor by displayed lines instead of file lines
" Use env var to optionally swap J & K keys: more intuitive on Colemak layouts
if $VIMSWAPJK == "true"
    noremap j gk
    noremap k gj
    noremap gj k
    noremap gk j
else
    noremap j gj
    noremap k gk
    noremap gj j
    noremap gk k
endif
noremap <Up> gk
noremap <Down> gj

" Improve beginning/end-of-line jumping since I don't use default H/L behavior
noremap H ^
noremap L $
vnoremap L g_

" Plugin key bindings ---------------------------------------------------------

" Backslash invokes ack.vim
nnoremap \ :Ack<SPACE>
