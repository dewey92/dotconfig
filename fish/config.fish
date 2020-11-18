source $HOME/.config/fish/aliases/main.fish
source $HOME/.config/fish/aliases/chordify.fish

# neofetch --disable theme icons term_font

set -x XDG_DATA_DIRS "/usr/local/share:/usr/share"

set -x FD_OPTIONS "--follow --exclude .git --exclude node_modules"
set -x FZF_DEFAULT_OPTS "--layout=reverse --preview \"bat --style=numbers --color=always {}\""
set -x FZF_DEFAULT_COMMAND "fd --hidden $FD_OPTIONS"

set -x BAT_THEME "TwoDark"

set -x VISUAL "nvim"
set -x EDITOR "nvim"
set -x TERMINAL "kitty"
