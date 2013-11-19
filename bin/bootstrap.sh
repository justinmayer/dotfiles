#!/usr/bin/env bash

# Exit immediately if a command exits with a non-zero status
set -e

export OS=`uname -s | sed -e 's/  */-/g;y/ABCDEFGHIJKLMNOPQRSTUVWXYZ/abcdefghijklmnopqrstuvwxyz/'`

if [ "$OS" = "darwin" ]; then
    export ARCHFLAGS="-arch x86_64"
    PIP_PREFIX="/usr/local/bin/pip"
    TOOLS_HOME=$HOME/Tools
    PROJECTS_HOME=$HOME/Projects
    VIRTUALENVS_HOME=$HOME/Virtualenvs
    chflags nohidden $HOME/Library

    # Install Homebrew
    [ ! -f /usr/local/bin/brew ] && /usr/bin/ruby -e "$(curl -fsSL https://raw.github.com/mxcl/homebrew/go)"

    # Install basic packages
    for pkg in wget mosh ssh-copy-id vcprompt
    do
        [ ! -f /usr/local/bin/$pkg ] && brew install $pkg
    done

    # Install Python with up-to-date OpenSSL
    if [ ! -f /usr/local/bin/python ]; then
        brew install python --with-brewed-openssl
        export PATH=/usr/local/bin:$PATH
        /usr/local/bin/pip install --upgrade pip setuptools
    fi

    # If Dropbox is present, symlink the Projects contained within
    if [ -d $HOME/Dropbox/Projects/dotfiles ]; then
        test -L "$PROJECTS_HOME" || ln -s "$HOME/Dropbox/Projects" "$PROJECTS_HOME"
        test -L "$TOOLS_HOME" || ln -s "$HOME/Dropbox/Projects/dotfiles" "$TOOLS_HOME"
    fi

    # Install fish and make it the default shell
    if [ ! -f /usr/local/bin/fish ]; then
        brew install fish
        echo "/usr/local/bin/fish" | sudo tee -a /etc/shells
        echo -e "\nChanging default shell to fish..."
        chsh -s /usr/local/bin/fish
    fi
fi

if [ "$OS" = "linux" ]; then
    PIP_PREFIX="sudo /usr/local/bin/pip"
    TOOLS_HOME=$HOME/tools
    PROJECTS_HOME=$HOME/projects
    VIRTUALENVS_HOME=$HOME/virtualenvs

    # Install basic packages
    for pkg in build-essential python-dev python-software-properties vim git mosh
    do
        sudo apt-get -y install $pkg
    done

    # Install setuptools and pip
    [ ! -f /usr/local/bin/easy_install ] && /usr/bin/wget https://bitbucket.org/pypa/setuptools/raw/bootstrap/ez_setup.py -O - | sudo python2.7
    [ ! -f /usr/local/bin/pip ] && /usr/bin/wget https://raw.github.com/pypa/pip/master/contrib/get-pip.py -O - | sudo python2.7

    # Install fish and make it the default shell
    if [ ! -f /usr/bin/fish ]; then
        sudo apt-add-repository -y ppa:fish-shell/release-2
        sudo apt-get update
        sudo apt-get -y install fish
        echo -e "\nChanging default shell for current user to fish..."
        sudo chsh -s /usr/bin/fish $USER
    fi

    # Install vcprompt
    if [ ! -f /usr/local/bin/vcprompt ]; then
        wget -O /tmp/vcprompt.tar.gz https://bitbucket.org/gward/vcprompt/downloads/vcprompt-1.1.tar.gz
        cd /tmp && tar -xzf vcprompt.tar.gz
        cd /tmp/vcprompt-* && make
        sudo cp /tmp/vcprompt-*/vcprompt /usr/local/bin/
    fi
fi

# Install global Python packages
unset PIP_REQUIRE_VIRTUALENV
[ ! -f /usr/local/bin/virtualenv ] && $PIP_PREFIX install virtualenv
[ ! -f /usr/local/bin/hg ] && $PIP_PREFIX install Mercurial
[ ! -f /usr/local/bin/dulwich ] && $PIP_PREFIX install hg-git
export PIP_REQUIRE_VIRTUALENV="true"

# Create .hgrc and .hgrc_local files if not present
if [ ! -f $HOME/.hgrc ]; then
    echo -e "\nNo ~/.hgrc detected."
    echo -e "\n# Local settings\n%include ~/.hgrc_local" > $HOME/.hgrc
    read -p "Enter your full name: " -e FULLNAME
    read -p "Enter your email address: " -e EMAIL
    echo -e "[ui]\nusername = $FULLNAME <$EMAIL>" > $HOME/.hgrc_local
    echo -e "\n[hostfingerprints]\nbitbucket.org = 24:9c:45:8b:9c:aa:ba:55:4e:01:6d:58:ff:e4:28:7d:2a:14:ae:3b" >> $HOME/.hgrc_local
fi

# Retrieve command-line tools (if Dropbox is not present)
test -d $TOOLS_HOME || hg clone https://bitbucket.org/j/dotfiles $TOOLS_HOME

# Create needed directories
mkdir -p $HOME/.config/fish $TOOLS_HOME/vim/bundle $TOOLS_HOME/lib/{fish,hg}
mkdir -p $HOME/.pip/{cache,wheels} $VIRTUALENVS_HOME

# Install Fish libraries
test -d $TOOLS_HOME/lib/fish/virtualfish || git clone git://github.com/justinmayer/virtualfish.git $TOOLS_HOME/lib/fish/virtualfish

# Install hg-prompt
test -d $TOOLS_HOME/lib/hg/hg-prompt || hg clone https://bitbucket.org/sjl/hg-prompt $TOOLS_HOME/lib/hg/hg-prompt

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

printf "Bootstrap process completed.\n"
