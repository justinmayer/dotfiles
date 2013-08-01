# Environment variables -------------------------------------------------------

prepend_to_path "/usr/local/sbin"
prepend_to_path "/usr/local/bin"
prepend_to_path "/usr/local/share/npm/bin"         # Mac NPM-installed binaries
prepend_to_path "$HOME/.local/bin"                 # Custom-compiled binaries
deduplicate PATH                                   # Clear duplicates in path

set fish_greeting

set -x ARCHFLAGS "-arch x86_64"
set -x EDITOR vim
set -x LC_ALL en_US.UTF-8

# Python variables

set -x PIP_REQUIRE_VIRTUALENV "true"
set -x PIP_USE_WHEEL "true"
set -x PIP_WHEEL_DIR "$HOME/.pip/wheels"
set -x PIP_FIND_LINKS "$HOME/.pip/wheels"
set -x PIP_DOWNLOAD_CACHE "$HOME/.pip/cache"
