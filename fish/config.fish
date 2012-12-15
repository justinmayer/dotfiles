# Useful aliases --------------------------------------------------------------

alias serve_this "python -m SimpleHTTPServer"

# Environment variables -------------------------------------------------------

prepend_to_path "/usr/local/sbin"
prepend_to_path "/usr/local/bin"
prepend_to_path "/usr/local/share/python"          # Mac pip-installed binaries
prepend_to_path "$HOME/.local/bin"
deduplicate PATH                                   # Clear duplicates in path

set BROWSER open

set -g -x ARCHFLAGS "-arch x86_64"
