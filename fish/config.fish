# Useful aliases --------------------------------------------------------------

alias serve_this "python -m SimpleHTTPServer"

# Environment variables -------------------------------------------------------

set PATH "/usr/local/bin" $PATH
prepend_to_path "/usr/local/sbin"
prepend_to_path "/usr/local/share/python"          # Mac pip-installed binaries

set BROWSER open

set -g -x ARCHFLAGS "-arch x86_64"
