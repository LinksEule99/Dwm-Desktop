if status is-interactive
    # Commands to run in interactive sessions can go here
end
# Guix setup for Fish
set -x GUIX_PROFILE $HOME/.guix-profile
if test -L $GUIX_PROFILE
    bass source $GUIX_PROFILE/etc/profile
end

# Add Guix to PATH if installed
if test -d /var/guix/profiles/per-user/root/current-guix/bin
    set -x PATH /var/guix/profiles/per-user/root/current-guix/bin $PATH
end

set -x GUIX_LOCPATH $HOME/.guix-profile/lib/locale

export GUIX_PROFILE="$HOME/.guix-profile"
export PATH="$GUIX_PROFILE/bin:$PATH"
export INFOPATH="$GUIX_PROFILE/share/info:$INFOPATH"
export MANPATH="$GUIX_PROFILE/share/man:$MANPATH"
set -x TERM rxvt-unicode-256color
set -e COLORTERM

alias ls="eza -la --icons"
alias cat="bat"
alias ff="fastfetch"
alias finst="cd ~/.config/flexipatch-finalizer/ && ./flexipatch-finalizer.sh -r -d ~/.config/st-flexipatch/ -o ~/.config/st"
alias fix="killall dwmblocks && killall pipewire"
alias tf="tinyfetch

bind \ec fzf_select_directory
