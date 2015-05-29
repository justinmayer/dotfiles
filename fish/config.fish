# Environment variables -------------------------------------------------------

set fish_greeting

set -x ARCHFLAGS "-arch x86_64"
set -x EDITOR vim
set -x LC_ALL en_US.UTF-8

# Python variables

set -x PIP_REQUIRE_VIRTUALENV "true"
set -x PIP_USE_WHEEL "true"
set -x PIP_WHEEL_DIR "$HOME/.pip/wheels"
set -x PIP_FIND_LINKS "$HOME/.pip/wheels"
set -x PIP_TIMEOUT 15
set -x PIP_ALLOW_ALL_EXTERNAL "false"
set -x PIP_NO_ALLOW_INSECURE "false"

set -x WORKON_HOME "$HOME/virtualenvs"
set -x PROJECT_HOME "$HOME/Projects"
set -g VIRTUALFISH_HOME $WORKON_HOME
set -g VIRTUALFISH_COMPAT_ALIASES "True"

# Load fish functions and modules ---------------------------------------------

set tacklebox_path $HOME/.tackle
set tacklebox_modules virtualfish virtualhooks
set tacklebox_plugins docker extract hg grc pip python up vundle
set tacklebox_theme entropy
source $HOME/.tacklebox/tacklebox.fish

# Set PATH --------------------------------------------------------------------

_prepend_path /Applications/Postgres.app/Contents/Versions/*/bin
_prepend_path "/usr/local/sbin"
_prepend_path "/usr/local/bin"
_prepend_path "$HOME/.local/bin"
