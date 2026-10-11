# Initial set-up

Install Chezmoi and Fish via Homebrew:

    brew update
    brew install chezmoi fish

If you want to have habit reminders on shell startup, add:

    brew install fortune boxes lolcat

Retrieve and apply dotfiles:

    chezmoi init justinmayer

Do a dry run of `chezmoi apply`:

    chezmoi apply --dry-run --verbose

Apply the configuration:

    chezmoi apply

Add Fish to `/etc/shells` and set as default shell:

    command -v fish | sudo tee -a /etc/shells
    chsh -s "$(command -v fish)"

Install Plug.fish:

    mkdir -p ~/.local/share/fish/plugins
    git clone https://github.com/kidonng/plug.fish ~/.local/share/fish/plugins/plug.fish

Install iTerm shell integration:

    curl -L https://iterm2.com/shell_integration/fish -o ~/.config/fish/iterm.fish

Spawn a new terminal session to load Fish. Then add `~/.local/bin` to `$PATH` as a persistent universal variable via [`fish_add_path`](https://fishshell.com/docs/current/cmds/fish_add_path.html):

    fish_add_path "$HOME/.local/bin"

# Updates

To pull and apply the latest changes:

    chezmoi update
