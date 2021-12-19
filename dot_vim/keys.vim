" Directional keys ------------------------------------------------------------

" When wrapping is on, move cursor by displayed lines instead of file lines
noremap j gj
noremap k gk
noremap gj j
noremap gk k

" Improve beginning/end-of-line jumping since I don't use default H/L behavior
noremap H ^
noremap L $
vnoremap L g_

" Plugin key bindings ---------------------------------------------------------

" Backslash invokes ack.vim
nnoremap \ :Ack<SPACE>
