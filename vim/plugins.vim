" Powerline -------------------------------------------------------------------

" Following conditional fixes issue with pre-compiled MacVim and Powerline
if filereadable("/usr/local/Frameworks/Python.framework/Versions/2.7/Python")
    let $PYTHONHOME="/usr/local/Frameworks/Python.framework/Versions/2.7"
endif
python from powerline.vim import setup as powerline_setup
python powerline_setup()
python del powerline_setup
set laststatus=2                       " Always show the statusline

" ack.vim: use ripgrep/ag if available ----------------------------------------

if executable('rg')
    let g:ackprg = 'rg -S --no-heading --vimgrep'
elseif executable('ag')
    let g:ackprg = 'ag --vimgrep'
endif
