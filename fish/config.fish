# Environment variables -------------------------------------------------------

prepend_to_path "/usr/local/sbin"
prepend_to_path "/usr/local/bin"
prepend_to_path "/usr/local/share/python"          # Mac pip-installed binaries
prepend_to_path "$HOME/.local/bin"
deduplicate PATH                                   # Clear duplicates in path

set fish_greeting

set -x ARCHFLAGS "-arch x86_64"
set -x EDITOR vim
set -x LC_ALL en_US.UTF-8

# Python variables

set -x PIP_DOWNLOAD_CACHE "$HOME/.pip/cache"
set -x PIP_REQUIRE_VIRTUALENV "true"
