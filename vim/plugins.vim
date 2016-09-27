" Powerline -------------------------------------------------------------------

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
