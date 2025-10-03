if status is-interactive
    # Commands to run in interactive sessions can go here
end

# Basic Guix setup - minimal and fast
set -gx GUIX_PROFILE $HOME/.guix-profile
set -gx PATH $GUIX_PROFILE/bin $PATH
set -gx GUIX_LOCPATH $GUIX_PROFILE/lib/locale

# Add system Guix if available
if test -d /var/guix/profiles/per-user/root/current-guix/bin
    set -gx PATH /var/guix/profiles/per-user/root/current-guix/bin $PATH
end

# Simple aliases and functions
function ls
    command eza -la --icons $argv
end

function cat
    command bat $argv
end

alias ff="fastfetch"
alias finst="cd ~/.config/flexipatch-finalizer/ && ./flexipatch-finalizer.sh -r -d ~/.config/st-flexipatch/ -o ~/.config/st"
alias fix="killall dwmblocks && killall pipewire"
#alias vim="nvim"
alias tf="tinyfetch"

bind \ec fzf_select_directory

# Skip the complex profile sourcing - most Guix packages will work without it
