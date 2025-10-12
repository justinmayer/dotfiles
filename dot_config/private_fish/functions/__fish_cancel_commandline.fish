# https://github.com/fish-shell/fish-shell/issues/3535#issuecomment-259333045
function __fish_cancel_commandline
    commandline ""
    commandline -f repaint
end
