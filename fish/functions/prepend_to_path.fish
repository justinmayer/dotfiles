function prepend_to_path -d "Prepend the given dir to PATH if it exists and is not already in PATH"
    if test -d $argv[1]
        if not contains $argv[1] $PATH
            set -g -x PATH "$argv[1]" $PATH
        end
    end
end
