#!/usr/bin/env bash

# Exit immediately if a command exits with a non-zero status
set -e

export OS=`uname -s | sed -e 's/  */-/g;y/ABCDEFGHIJKLMNOPQRSTUVWXYZ/abcdefghijklmnopqrstuvwxyz/'`

if [ "$OS" = "darwin" ]; then
    export ARCHFLAGS="-arch x86_64"
    TOOLS_HOME=$HOME/Tools
    PROJECTS_HOME=$HOME/Projects
    VIRTUALENVS_HOME=$HOME/Virtualenvs
    PYHOME=/usr/local
    chflags nohidden $HOME/Library

    # Install Homebrew
    if [ ! -f /usr/local/bin/brew ]; then
        /usr/bin/ruby -e "$(curl -fsSL https://raw.github.com/mxcl/homebrew/go)"
    fi

    # Install basic packages
    for pkg in ssh-copy-id wget
    do
        test -f /usr/local/bin/$pkg || brew install $pkg
    done

    # Install Python with up-to-date OpenSSL
    if [ ! -f /usr/local/bin/python ]; then
        brew install python --with-brewed-openssl
        PATH=/usr/local/bin:$PATH
        $PYHOME/bin/pip install --upgrade pip setuptools
    fi

    # Install Mercurial, hg-git, and Virtualenv:
    PIP_REQUIRE_VIRTUALENV="" $PYHOME/bin/pip install Mercurial hg-git virtualenv

    # If Dropbox is present, symlink the Projects contained within
    if [ -d $HOME/Dropbox/Projects/dotfiles ]; then
        test -L "$PROJECTS_HOME" || ln -s "$HOME/Dropbox/Projects" "$PROJECTS_HOME"
        test -L "$TOOLS_HOME" || ln -s "$HOME/Dropbox/Projects/dotfiles" "$TOOLS_HOME"
    fi

    # Install fish and make it the default shell
    if [ ! -f /usr/local/bin/fish ]; then
        brew install fish
        echo "/usr/local/bin/fish" | sudo tee -a /etc/shells
        chsh -s /usr/local/bin/fish
    fi
fi

# Create .hgrc and .hgrc_local files if not present
if [ ! -f ~/.hgrc ]; then
    echo -e "\nNo ~/.hgrc detected."
    echo -e "\n# Local settings\n%include ~/.hgrc_local" > ~/.hgrc
    read -p "Enter your full name: " -e FULLNAME
    read -p "Enter your email address: " -e EMAIL
    echo -e "[ui]\nusername = $FULLNAME <$EMAIL>" > ~/.hgrc_local
    echo -e "\n[hostfingerprints]\nbitbucket.org = 24:9c:45:8b:9c:aa:ba:55:4e:01:6d:58:ff:e4:28:7d:2a:14:ae:3b" >> ~/.hgrc_local
fi

# Retrieve command-line tools (if Dropbox is not present)
test -d $TOOLS_HOME || hg clone https://bitbucket.org/j/dotfiles $TOOLS_HOME

# Create needed directories
mkdir -p $HOME/.config/fish $TOOLS_HOME/vim/bundle $TOOLS_HOME/lib/{fish,hg}
mkdir -p $HOME/.pip/{cache,wheels} $VIRTUALENVS_HOME

# Install Fish libraries
test -d $TOOLS_HOME/lib/fish/virtualfish || git clone git://github.com/justinmayer/virtualfish.git $TOOLS_HOME/lib/fish/virtualfish

# If ~/.hgrc isn't a symlink, move it out of the way so symlink can be created
test -L $HOME/.hgrc || mv $HOME/.hgrc $HOME/.hgrc.bak

# Ensure symlinks
function ensure_link {
    test -L "$HOME/$2" || ln -s "$TOOLS_HOME/$1" "$HOME/$2"
}

ensure_link "fish/config.fish"                 ".config/fish/config.fish"
ensure_link "fish/functions"                   ".config/fish/functions"
ensure_link "gitconfig"                        ".gitconfig"
ensure_link "hgignore"                         ".hgignore"
ensure_link "hgrc"                             ".hgrc"
ensure_link "vim"                              ".vim"
ensure_link "vim/vimrc"                        ".vimrc"
ensure_link "vim/gvimrc"                       ".gvimrc"

# Install Vundle
test -d $TOOLS_HOME/vim/bundle/vundle || git clone http://github.com/gmarik/vundle.git $TOOLS_HOME/vim/bundle/vundle
SHELL=$(which sh) vim +BundleInstall +qall
