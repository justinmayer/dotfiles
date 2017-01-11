" Powerline -------------------------------------------------------------------

" Following conditional fixes issue with pre-compiled MacVim and Powerline
if filereadable("/usr/local/Frameworks/Python.framework/Versions/2.7/Python")
    let $PYTHONHOME="/usr/local/Frameworks/Python.framework/Versions/2.7"
endif
if has('python')
    python from powerline.vim import setup as powerline_setup
    python powerline_setup()
    python del powerline_setup
elseif has('python3')
    python3 from powerline.vim import setup as powerline_setup
    python3 powerline_setup()
    python3 del powerline_setup
endif
set laststatus=2   " Always show the statusline in all windows
set showtabline=2  " Always display the tabline, even if there is only one tab

" ack.vim: use ripgrep/ag if available ----------------------------------------

if executable('rg')
    let g:ackprg = 'rg -S --no-heading --vimgrep'
elseif executable('ag')
    let g:ackprg = 'ag --vimgrep'
endif
