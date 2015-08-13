#!/usr/bin/env bash

# Exit immediately if a command exits with a non-zero status
set -e

export OS=`uname -s | sed -e 's/  */-/g;y/ABCDEFGHIJKLMNOPQRSTUVWXYZ/abcdefghijklmnopqrstuvwxyz/'`

if [ "$OS" = "darwin" ]; then
    export ARCHFLAGS="-arch x86_64"
    PIP_PREFIX="/usr/local/bin/pip"
    PROJECTS_HOME=$HOME/Projects
    VIRTUALENVS_HOME=$HOME/Virtualenvs
    chflags nohidden $HOME/Library

    # Install Homebrew
    [ ! -f /usr/local/bin/brew ] && /usr/bin/ruby -e "$(curl -fsSL https://raw.github.com/mxcl/homebrew/go)"

    # Install basic packages
    for pkg in git grc pixz ssh-copy-id vcprompt wget
    do
        [ ! -f /usr/local/bin/$pkg ] && brew install $pkg
    done

    # Install GNU tar
    [ ! -f /usr/local/bin/gtar ] && brew install gnu-tar

    # Install Python
    if [ ! -f /usr/local/bin/python ]; then
        brew install python
        export PATH=/usr/local/bin:$PATH
        PIP_REQUIRE_VIRTUALENV="" /usr/local/bin/pip install --upgrade pip setuptools
    fi

    # If ~/Projects/dotfiles is present, symlink it to ~/.dotfiles
    if [ -d $PROJECTS_HOME/dotfiles ]; then
        test -L "$HOME/.dotfiles" || ln -s "$HOME/Projects/dotfiles" "$HOME/.dotfiles"
    fi

    # Install fish and make it the default shell
    if [ ! -f /usr/local/bin/fish ]; then
        brew install fish
        echo "/usr/local/bin/fish" | sudo tee -a /etc/shells
        echo -e "\nChanging default shell to fish..."
        chsh -s /usr/local/bin/fish
    fi

    # Retrieve Powerline fonts
    if [ ! -d $HOME/Library/Fonts/Menlo\ for\ Powerline ]; then
        mkdir -p $HOME/Library/Fonts
        git clone https://gist.github.com/7537418.git /tmp/menlo
        cd /tmp/menlo && unzip Menlo-for-Powerline.zip
        mv /tmp/menlo/Menlo\ for\ Powerline $HOME/Library/Fonts/
    fi

    # Install MacVim
    if [ ! -L /Applications/Macvim.app ]; then
        brew install macvim --override-system-vim
        ln -s /usr/local/Cellar/macvim/*/MacVim.app /Applications/MacVim.app
    fi
fi

if [ "$OS" = "linux" ]; then
    PIP_PREFIX="sudo /usr/local/bin/pip"
    PROJECTS_HOME=$HOME/projects
    VIRTUALENVS_HOME=$HOME/virtualenvs

    # Install basic packages
    for pkg in build-essential python-dev software-properties-common python-software-properties vim git grc pixz
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
        wget -O /tmp/vcprompt.tar.gz https://bitbucket.org/gward/vcprompt/downloads/vcprompt-1.2.1.tar.gz
        cd /tmp && tar -xzf vcprompt.tar.gz
        cd /tmp/vcprompt-* && ./configure && make
        sudo cp /tmp/vcprompt-*/vcprompt /usr/local/bin/
    fi
fi

# Install global Python packages
unset PIP_REQUIRE_VIRTUALENV
[ ! -f /usr/local/bin/virtualenv ] && $PIP_PREFIX install virtualenv
[ ! -f /usr/local/bin/hg ] && $PIP_PREFIX install Mercurial
[ ! -f /usr/local/bin/dulwich ] && $PIP_PREFIX install hg-git
[ ! -f /usr/local/bin/isort ] && $PIP_PREFIX install isort
[ ! -f /usr/local/bin/powerline ] && $PIP_PREFIX install powerline-status
export PIP_REQUIRE_VIRTUALENV="true"

# If .hgrc or .gitlocal isn't present, ask for name and email address
if [ ! -f $HOME/.hgrc ] || [ ! -f $HOME/.gitlocal ]; then
    read -p "Enter your full name: " -e FULLNAME
    read -p "Enter your email address: " -e EMAIL
fi

# Create .hgrc and .hgrc_local files if not present
if [ ! -f $HOME/.hgrc ]; then
    echo -e "\nNo ~/.hgrc detected."
    echo -e "\n# Local settings\n%include ~/.hgrc_local" > $HOME/.hgrc
    echo -e "[ui]\nusername = $FULLNAME <$EMAIL>" > $HOME/.hgrc_local
    echo -e "\n[hostfingerprints]\nbitbucket.org = 46:de:34:e7:9b:18:cd:7f:ae:fd:8b:e3:bc:f4:1a:5e:38:d7:ac:24" >> $HOME/.hgrc_local
fi

# Create .gitlocal file if not present
if [ ! -f $HOME/.gitlocal ]; then
    echo -e "[user]\n    name = $FULLNAME\n    email = $EMAIL" > $HOME/.gitlocal
fi

# Retrieve dotfiles (if not symlinked from ~/Projects/dotfiles)
test -d $HOME/.dotfiles || hg clone https://bitbucket.org/j/dotfiles $HOME/.dotfiles

# Create needed directories
mkdir -p $HOME/.config/fish $HOME/.dotfiles/vim/bundle $HOME/.dotfiles/lib/{fish,hg}
mkdir -p $VIRTUALENVS_HOME

# Install Fish libraries
if [ -d $PROJECTS_HOME ]; then
    [ -d $PROJECTS_HOME/tacklebox ] || git clone git://github.com/justinmayer/tacklebox.git $PROJECTS_HOME/tacklebox
    [ -d $PROJECTS_HOME/tackle ] || git clone git://github.com/justinmayer/tackle.git $PROJECTS_HOME/tackle
    [ -L $HOME/.tacklebox ] || ln -s $PROJECTS_HOME/tacklebox $HOME/.tacklebox
    [ -L $HOME/.tackle ] || ln -s $PROJECTS_HOME/tackle $HOME/.tackle
else
    [ -d $HOME/.tacklebox ] || git clone git://github.com/justinmayer/tacklebox.git $HOME/.tacklebox
    [ -d $HOME/.tackle ] || git clone git://github.com/justinmayer/tackle.git $HOME/.tackle
fi

# Retrieve iTerm fish shell integration
wget -O $HOME/.config/fish/iterm.fish http://iterm2.com/misc/fish_startup.in

# Install hg-prompt
test -d $HOME/.dotfiles/lib/hg/hg-prompt || hg clone https://bitbucket.org/sjl/hg-prompt $HOME/.dotfiles/lib/hg/hg-prompt

# If ~/.hgrc isn't a symlink, move it out of the way so symlink can be created
test -L $HOME/.hgrc || mv $HOME/.hgrc $HOME/.hgrc.bak

# Ensure symlinks
function ensure_link {
    test -L "$HOME/$2" || ln -s "$HOME/.dotfiles/$1" "$HOME/$2"
}

ensure_link "fish/config.fish"                 ".config/fish/config.fish"
ensure_link "fish/functions"                   ".config/fish/functions"
ensure_link "gitconfig"                        ".gitconfig"
ensure_link "gitignore"                        ".gitignore"
ensure_link "hgignore"                         ".hgignore"
ensure_link "hgrc"                             ".hgrc"
ensure_link "vim"                              ".vim"
ensure_link "vim/vimrc"                        ".vimrc"
ensure_link "vim/gvimrc"                       ".gvimrc"

# Install Vundle
test -d $HOME/.dotfiles/vim/bundle/vundle || git clone http://github.com/gmarik/vundle.git $HOME/.dotfiles/vim/bundle/vundle
SHELL=$(which sh) vim +BundleInstall +qall

printf "Bootstrap process completed.\n"
