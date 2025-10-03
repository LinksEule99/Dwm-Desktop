function fzf_select_directory
    set -l dir (fd -t d -H . ~ 2>/dev/null | fzf --height=40% --reverse --border --preview 'ls -la {}')
    if test -n "$dir"
        commandline -i "$dir"
    end
    commandline -f repaint
end
