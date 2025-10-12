function fish_greeting
    # Display random habit, if required executables exist.
    if command -q fortune; and command -q lolcat; and command -q boxes
        fortune $HOME/.local/share/habits | lolcat -f | boxes -d ansi-rounded
    end
end
